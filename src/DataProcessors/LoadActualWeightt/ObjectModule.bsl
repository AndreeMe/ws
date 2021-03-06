Функция ВыполнитьПриложение(ХранилищеЗначения, IDСообщения) Экспорт
	
	Сообщение = ХранилищеЗначения.Получить();
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(Сообщение);
	ОбXDTO = ФабрикаXDTO.ПрочитатьXML(ЧтениеXML);
	ЧтениеXML.Закрыть();
	
	Сообщения = "";
	
	Если ТипЗнч(ОбXDTO) = Тип("ОбъектXDTO") Тогда
		Результат = Обработать(ОбXDTO, IDСообщения);
	ИначеЕсли ТипЗнч(ОбXDTO) = Тип("СписокXDTO") Тогда
		Для каждого Item Из ОбXDTO Цикл
			Результат = Сообщения + " 
			|" + Обработать(Item, IDСообщения);
		КонецЦикла; 
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// обрабатываем не ТН, а Распоряжение на провес
Функция Обработать(Item, IDСообщения)
	
	Результат = Новый Структура("Документ, Сообщение", Неопределено, "");
	
	// Найти ТН по UID
	UID = Новый УникальныйИдентификатор(Item.UID);
	РаспоряжениеНаПровес = Документы.АЭМ_РаспоряжениеНаПровес.ПолучитьСсылку(UID);
	
	Если Не ЗначениеЗаполнено(РаспоряжениеНаПровес) ИЛИ Не ЗначениеЗаполнено(РаспоряжениеНаПровес.Номер) Тогда
		Результат.Сообщение = "Не найден документ Распоряжение на провес с UID = " + UID;
		Возврат Результат;
	КонецЕсли; 
	
	РаспоряжениеНаПровесОбъект = РаспоряжениеНаПровес.ПолучитьОбъект();
	
	Попытка
		РаспоряжениеНаПровесОбъект.Заблокировать();
	Исключение
		// не в этот раз...
		Результат.Сообщение = Строка(РаспоряжениеНаПровес) + ": не удалось заблокировать объект.";
		Возврат Результат;	
	КонецПопытки;
	
	// пересчет из кг в тонны не нужен, это сделано в АСЖДВ...
	РаспоряжениеНаПровесОбъект.КоличествоФактическое = Item.Weight;
	РаспоряжениеНаПровесОбъект.Статус = Перечисления.АЭМ_СтатусыРаспоряженийНаПровес.Взвешено;
	
	Попытка
		РаспоряжениеНаПровесОбъект.Записать();
	Исключение
		Результат.Сообщение = Строка(РаспоряжениеНаПровес) + ": не удалось записать документ.";
		Возврат Результат;	
	КонецПопытки;
	
	Результат.Документ = ПолучитьНавигационнуюСсылку(РаспоряжениеНаПровесОбъект);
	
	Возврат Результат; 
	
КонецФункции // ()

// устарело
Функция Обработать_ТН(Item, IDСообщения)
	
	Результат = Новый Структура("Документ, Сообщение", Неопределено, "");
	
	// Найти ТН по UID
	UID = Новый УникальныйИдентификатор(Item.UID);
	ТранспортнаяНакладная = Документы.ТранспортнаяНакладная.ПолучитьСсылку(UID);
	
	Если Не ЗначениеЗаполнено(ТранспортнаяНакладная) ИЛИ Не ЗначениеЗаполнено(ТранспортнаяНакладная.Номер) Тогда
		ТранспортнаяНакладная = Документы.АЭМ_РаспоряжениеНаПровес.ПолучитьСсылку(UID);
		Результат.Сообщение = "Не найден документ Транcпортная накладная с UID = " + UID;
		Возврат Результат;
	КонецЕсли; 
	
	ДокументыОснования = ТранспортнаяНакладная.ДокументыОснования;
	Если ДокументыОснования.Количество() = 0 Тогда
		Результат.Сообщение = Строка(ТранспортнаяНакладная) + ": нет документов-оснований.";
		Возврат Результат;
	КонецЕсли; 
	
	Для каждого Строка Из ДокументыОснования Цикл
		Если ТипЗнч(Строка.ДокументОснование) = Тип("ДокументСсылка.АЭМ_РаспоряжениеНаПровес") Тогда
			РаспоряжениеНаПровес = Строка.ДокументОснование; 					
			Прервать;
		КонецЕсли;
	КонецЦикла; 
	
	Если Не ЗначениеЗаполнено(РаспоряжениеНаПровес) Тогда
		Результат.Сообщение = Строка(ТранспортнаяНакладная) + ": среди документов-оснований нет распоряжения на провес.";
		Возврат Результат;
	КонецЕсли; 
	
	РаспоряжениеНаПровесОбъект = РаспоряжениеНаПровес.ПолучитьОбъект();
	
	Попытка
		РаспоряжениеНаПровесОбъект.Заблокировать();
	Исключение
		// не в этот раз...
		Результат.Сообщение = Строка(РаспоряжениеНаПровес) + ": не удалось заблокировать объект.";
		Возврат Результат;	
	КонецПопытки;
	
	// здесь пересчет из кг в тонны не нужен, это сделано на стороне АСЖДВ...
	РаспоряжениеНаПровесОбъект.КоличествоФактическое = Item.Weight;
	РаспоряжениеНаПровесОбъект.Статус = Перечисления.АЭМ_СтатусыРаспоряженийНаПровес.Взвешено;
	
	Попытка
		РаспоряжениеНаПровесОбъект.Записать();
	Исключение
		Результат.Сообщение = Строка(РаспоряжениеНаПровес) + ": не удалось записать документ.";
		Возврат Результат;	
	КонецПопытки;
	
	Результат.Документ = РаспоряжениеНаПровес;
	
	Возврат Результат; 
	
КонецФункции // ()

