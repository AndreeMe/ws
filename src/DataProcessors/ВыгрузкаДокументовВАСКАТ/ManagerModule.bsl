Функция ВыполнитьПриложение(Ссылка, ТипПодключаемойОбработки) Экспорт
	
	Если ТипЗнч(Ссылка) = Тип("ДокументСсылка.АЭМ_РаспоряжениеНаПровес")  Тогда
		АЭМ_РаспоряжениеНаПровес(Ссылка, ТипПодключаемойОбработки);
	ИначеЕсли ТипЗнч(Ссылка) = Тип("ДокументСсылка.ПеремещениеТоваров")  Тогда
		ПеремещениеТоваров(Ссылка, ТипПодключаемойОбработки);
	ИначеЕсли ТипЗнч(Ссылка) = Тип("ДокументСсылка.ДвижениеПродукцииИМатериалов")  Тогда
		ДвижениеПродукцииИМатериалов(Ссылка, ТипПодключаемойОбработки);
	ИначеЕсли ТипЗнч(Ссылка) = Тип("ДокументСсылка.ПеремещениеОС2_4")  Тогда
		ПеремещениеОС2_4(Ссылка, ТипПодключаемойОбработки);
	ИначеЕсли ТипЗнч(Ссылка) = Тип("ДокументСсылка.ВозвратТоваровПоставщику")  Тогда
		ВозвратТоваровПоставщику(Ссылка, ТипПодключаемойОбработки);
	КонецЕсли; 
	
КонецФункции

Функция АЭМ_РаспоряжениеНаПровес(Ссылка, ТипПодключаемойОбработки)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	""Распоряжение на провес"" КАК type,
		|	АЭМ_РаспоряжениеНаПровес.Номер КАК number,
		|	АЭМ_РаспоряжениеНаПровес.Дата КАК date,
		|	АЭМ_РаспоряжениеНаПровес.СкладОтправитель.АЭМ_КодСклада КАК sender_ws,
		|	АЭМ_РаспоряжениеНаПровес.СкладПолучатель.АЭМ_КодСклада КАК recipient_ws,
		|	АЭМ_РаспоряжениеНаПровес.Ответственный.Наименование КАК author
		|ИЗ
		|	Документ.АЭМ_РаспоряжениеНаПровес КАК АЭМ_РаспоряжениеНаПровес
		|ГДЕ
		|	АЭМ_РаспоряжениеНаПровес.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	АЭМ_РаспоряжениеНаПровес.КоличествоПлановое КАК quantity,
		|	АЭМ_РаспоряжениеНаПровес.Номенклатура.Наименование КАК cargo,
		|	АЭМ_РаспоряжениеНаПровес.Номенклатура.ЕдиницаИзмерения.Наименование КАК unit,
		|	0 КАК amount
		|ИЗ
		|	Документ.АЭМ_РаспоряжениеНаПровес КАК АЭМ_РаспоряжениеНаПровес
		|ГДЕ
		|	АЭМ_РаспоряжениеНаПровес.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	Шапка = РезультатЗапроса[0].Выбрать();
	Шапка.Следующий();
	Груз  = РезультатЗапроса[1].Выбрать();
	Груз.Следующий();
	
	Выгрузить(Ссылка, Шапка, РезультатЗапроса[0].Колонки, Груз, РезультатЗапроса[1].Колонки, ТипПодключаемойОбработки);

КонецФункции // ()

Функция ПеремещениеТоваров(Ссылка, ТипПодключаемойОбработки)

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	""Перемещение товаров"" КАК type,
		|	ПеремещениеТоваров.Номер КАК number,
		|	ПеремещениеТоваров.Дата КАК date,
		|	ПеремещениеТоваров.СкладОтправитель.АЭМ_КодСклада КАК sender_ws,
		|	ПеремещениеТоваров.СкладПолучатель.АЭМ_КодСклада КАК recipient_ws,
		|	ПеремещениеТоваров.Ответственный.Наименование КАК author
		|ИЗ
		|	Документ.ПеремещениеТоваров КАК ПеремещениеТоваров
		|ГДЕ
		|	ПеремещениеТоваров.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ПеремещениеТоваровТовары.Номенклатура.Наименование КАК cargo,
		|	ПеремещениеТоваровТовары.Номенклатура.ЕдиницаИзмерения.Наименование КАК unit,
		|	0 КАК amount,
		|	ПеремещениеТоваровТовары.Количество КАК quantity
		|ИЗ
		|	Документ.ПеремещениеТоваров.Товары КАК ПеремещениеТоваровТовары
		|ГДЕ
		|	ПеремещениеТоваровТовары.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	Шапка = РезультатЗапроса[0].Выбрать();
	Шапка.Следующий();
	Груз  = РезультатЗапроса[1].Выбрать();
	Груз.Следующий();
	
	
	Выгрузить(Ссылка, Шапка, РезультатЗапроса[0].Колонки, Груз, РезультатЗапроса[1].Колонки, ТипПодключаемойОбработки);

КонецФункции // ()

Функция ДвижениеПродукцииИМатериалов(Ссылка, ТипПодключаемойОбработки)

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	""Движение продукции и материалов"" КАК type,
		|	ДвижениеПродукцииИМатериалов.Номер КАК number,
		|	ДвижениеПродукцииИМатериалов.Дата КАК date,
		|	ДвижениеПродукцииИМатериалов.Ответственный.Наименование КАК author,
		|	ВЫБОР
		|		КОГДА ДвижениеПродукцииИМатериалов.Отправитель.АЭМ_КодСклада ЕСТЬ NULL
		|			ТОГДА ДвижениеПродукцииИМатериалов.Отправитель.АЭМ_КодЦеха
		|		ИНАЧЕ ДвижениеПродукцииИМатериалов.Отправитель.АЭМ_КодСклада
		|	КОНЕЦ КАК sender_ws,
		|	ВЫБОР
		|		КОГДА ДвижениеПродукцииИМатериалов.Получатель.АЭМ_КодСклада ЕСТЬ NULL
		|			ТОГДА ДвижениеПродукцииИМатериалов.Получатель.АЭМ_КодЦеха
		|		ИНАЧЕ ДвижениеПродукцииИМатериалов.Получатель.АЭМ_КодСклада
		|	КОНЕЦ КАК recipient_ws
		|ИЗ
		|	Документ.ДвижениеПродукцииИМатериалов КАК ДвижениеПродукцииИМатериалов
		|ГДЕ
		|	ДвижениеПродукцииИМатериалов.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ДвижениеПродукцииИМатериаловТовары.Номенклатура.Наименование КАК cargo,
		|	ДвижениеПродукцииИМатериаловТовары.Номенклатура.ЕдиницаИзмерения.Наименование КАК unit,
		|	0 КАК amount,
		|	ДвижениеПродукцииИМатериаловТовары.Количество КАК quantity
		|ИЗ
		|	Документ.ДвижениеПродукцииИМатериалов.Товары КАК ДвижениеПродукцииИМатериаловТовары
		|ГДЕ
		|	ДвижениеПродукцииИМатериаловТовары.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	Шапка = РезультатЗапроса[0].Выбрать();
	Шапка.Следующий();
	Груз  = РезультатЗапроса[1].Выбрать();
	Груз.Следующий();
	
	Выгрузить(Ссылка, Шапка, РезультатЗапроса[0].Колонки, Груз, РезультатЗапроса[1].Колонки, ТипПодключаемойОбработки);

КонецФункции // ()

Функция ПеремещениеОС2_4(Ссылка, ТипПодключаемойОбработки)

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	""Перемещение ОС"" КАК type,
		|	ПеремещениеОС2_4.Номер КАК number,
		|	ПеремещениеОС2_4.Дата КАК date,
		|	ПеремещениеОС2_4.Ответственный.Наименование КАК author,
		|	ПеремещениеОС2_4.Подразделение.АЭМ_КодЦеха КАК sender_ws,
		|	ПеремещениеОС2_4.ПодразделениеПолучатель.АЭМ_КодЦеха КАК recipient_ws
		|ИЗ
		|	Документ.ПеремещениеОС2_4 КАК ПеремещениеОС2_4
		|ГДЕ
		|	ПеремещениеОС2_4.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	1 КАК quantity,
		|	0 КАК amount,
		|	""шт"" КАК unit,
		|	ПеремещениеОС2_4ОС.ОсновноеСредство.Наименование КАК cargo
		|ИЗ
		|	Документ.ПеремещениеОС2_4.ОС КАК ПеремещениеОС2_4ОС
		|ГДЕ
		|	ПеремещениеОС2_4ОС.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	Шапка = РезультатЗапроса[0].Выбрать();
	Шапка.Следующий();
	Груз  = РезультатЗапроса[1].Выбрать();
	Груз.Следующий();
	
	Выгрузить(Ссылка, Шапка, РезультатЗапроса[0].Колонки, Груз, РезультатЗапроса[1].Колонки, ТипПодключаемойОбработки);

КонецФункции // ()

Функция ВозвратТоваровПоставщику(Ссылка, ТипПодключаемойОбработки)

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	""Возврат товаров поставщику"" КАК type,
		|	ВозвратТоваровПоставщику.Номер КАК number,
		|	ВозвратТоваровПоставщику.Дата КАК date
		|ИЗ
		|	Документ.ВозвратТоваровПоставщику КАК ВозвратТоваровПоставщику
		|ГДЕ
		|	ВозвратТоваровПоставщику.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВозвратТоваровПоставщикуТовары.Номенклатура.Наименование КАК cargo,
		|	ВозвратТоваровПоставщикуТовары.Номенклатура.ЕдиницаИзмерения.Наименование КАК unit,
		|	0 КАК amount,
		|	ВозвратТоваровПоставщикуТовары.Количество КАК quantity
		|ИЗ
		|	Документ.ВозвратТоваровПоставщику.Товары КАК ВозвратТоваровПоставщикуТовары
		|ГДЕ
		|	ВозвратТоваровПоставщикуТовары.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	Шапка = РезультатЗапроса[0].Выбрать();
	Шапка.Следующий();
	Груз  = РезультатЗапроса[1].Выбрать();
	Груз.Следующий();
	
	Выгрузить(Ссылка, Шапка, РезультатЗапроса[0].Колонки, Груз, РезультатЗапроса[1].Колонки, ТипПодключаемойОбработки);

КонецФункции // ()

Функция Выгрузить(Ссылка, Шапка, КолонкиШапки, Груз, КолонкиГруз, ТипПодключаемойОбработки, Отказ = Ложь)
	
	document = ФабрикаXDTO.Создать(ФабрикаXDTO.Тип("http://aem", "MoveApplicationDocument"));   	
	item 	 = ФабрикаXDTO.Создать(ФабрикаXDTO.Тип("http://aem", "MoveApplicationItem"));  
	
	// <document author="M_CEKHMEJSTR" date="2020-08-27" 
	//    number="4901549277" 
	//		recipient='ПАО "СЕВЕРСТАЛЬ" Череповецкий МК ПАО "Северсталь" 162600 Череповец Мира,д.30' 
	//			recipient_ws="88" 
	//				sender='Общество с ограниченной ответственностью "ОМЗ-Спецсталь" 196650 Санкт-Петербург,город Колпино Территория Ижорский завод д. б/н, тел. (812)322-84-38' 
	//					sender_ws="20" 
	//						type="Z1T">
	//	<item cargo="брама, 104781-8-2, 104781, 8-2, 10Х2М" quantity="3.5" unit="Т" amount="381270.58"/>
	// </document>	
	

	// item
	item.cargo	  = XMLЗначение(Тип("Строка"), Груз["cargo"]);
	item.unit	  = XMLЗначение(Тип("Строка"), Груз["unit"]);
	item.quantity = Груз["quantity"];
	item.amount   = Груз["amount"];
	
	Для каждого Кол Из КолонкиШапки Цикл
		Если Кол.Имя = "type" Тогда
			// название документа
			document[Кол.Имя] = XMLСтрока(Шапка[Кол.Имя]);	
		ИначеЕсли Кол.Имя = "date" Тогда
			// надо преобразовать в: 2020-08-27
			document[Кол.Имя] = Формат(Шапка[Кол.Имя], "ДФ=yyyy-MM-dd");	
		Иначе
			Если ЗначениеЗаполнено(Шапка[Кол.Имя]) Тогда
				document[Кол.Имя] = XMLСтрока(Шапка[Кол.Имя]);	
			Иначе
				document[Кол.Имя] = XMLСтрока(Неопределено);	
			КонецЕсли; 
		КонецЕсли; 
	КонецЦикла; 
	
	// добавляем позицию в документ
	document.item.Добавить(item);
	
	ХМЛ = wsОбработчики.XDTOtoXML(document, ФабрикаXDTO);
	//ЗаписьХМЛ  = Новый ЗаписьXML;
	//ЗаписьХМЛ.УстановитьСтроку();
	//ФабрикаXDTO.ЗаписатьXML(ЗаписьХМЛ, document);
	//ХМЛ = ЗаписьХМЛ.Закрыть();
	
	
	Если ХМЛ = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли; 
	
	wsНастройкиВебСервисов =  wsОбработчики.ОписаниеВебСервиса(ТипПодключаемойОбработки);
	
	// Подключение
	Определения = Новый WSОпределения(wsНастройкиВебСервисов.МестоположениеWSDL, 
							wsНастройкиВебСервисов.ИмяПользователя, wsНастройкиВебСервисов.Пароль);
	
	Попытка
		Прокси = Новый WSПрокси(Определения, 
									wsНастройкиВебСервисов.URIПространстваИмен, 
											wsНастройкиВебСервисов.ИмяWEBСервиса, 
													wsНастройкиВебСервисов.ИмяТочкиПодключения,,60);
		Прокси.Пользователь = wsНастройкиВебСервисов.ИмяПользователя;
		Прокси.Пароль = wsНастройкиВебСервисов.Пароль;
		Результат = Прокси.exchange(ХМЛ, "АВТО"); // тип = АВТО, ЖД, договорились, что всегда "АВТО"
		Если Результат Тогда
//			Сообщить("Готово.");
		Иначе
			Сообщить("Ошибка на стороне приемника.");
		КонецЕсли; 
	Исключение
		Отказ = Истина;
		Сообщить("Ошибка: " + ОписаниеОшибки());
	КонецПопытки;
	
	Если Не Отказ Тогда
		// пишем сообщение в регистр на память
		wsОбработчики.ЗаписатьСообщениеВОчередьСообщений(
				ХМЛ, 
					ТипПодключаемойОбработки, 
						Перечисления.wsНаправлениеСообщения.Исходящее,,
							Ссылка, Истина); // обработано
	
	КонецЕсли; 

КонецФункции // ()
