Функция ВыполнитьПриложение(Ссылка, ТипПодключаемойОбработки) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Организация.Наименование КАК ОрганизацияНаименование,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Организация.ИНН КАК ОрганизацияИНН,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Организация.КПП КАК ОрганизацияКПП,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Грузоотправитель.Наименование КАК ГрузоотправительНаименование,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Грузоотправитель.ИНН КАК ГрузоотправительИНН,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Грузоотправитель.КПП КАК ГрузоотправительКПП,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Грузополучатель.Наименование КАК ГрузополучательНаименование,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Грузополучатель.ИНН КАК ГрузополучательИНН,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Грузополучатель.КПП КАК ГрузополучательКПП,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Перевозчик.Наименование КАК ПеревозчикНаименование,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Перевозчик.ИНН КАК ПеревозчикИНН,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Перевозчик.КПП КАК ПеревозчикКПП,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Плательщик.Наименование КАК ПлательщикНаименование,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Плательщик.ИНН КАК ПлательщикИНН,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Плательщик.КПП КАК ПлательщикКПП,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.АвтомобильГосударственныйНомер КАК АвтомобильГосударственныйНомер,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.АвтомобильМарка КАК АвтомобильМарка,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.АвтомобильТип КАК АвтомобильТип,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Водитель КАК Водитель,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка.Прицеп КАК Прицеп,
		|	ТранспортнаяНакладнаяДокументыОснования.ДокументОснование КАК ДокументОснование,
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.ТранспортнаяНакладная.ДокументыОснования КАК ТранспортнаяНакладнаяДокументыОснования
		|ГДЕ
		|	ТранспортнаяНакладнаяДокументыОснования.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Если ТипЗнч(Выборка.ДокументОснование) = Тип("ДокументСсылка.РеализацияТоваровУслуг")  Тогда
			РеализацияТоваровУслуг(Выборка, ТипПодключаемойОбработки);
		ИначеЕсли ТипЗнч(Выборка.ДокументОснование) = Тип("ДокументСсылка.ВозвратТоваровПоставщику")  Тогда
			ВозвратТоваровПоставщику(Выборка, ТипПодключаемойОбработки);
		ИначеЕсли ТипЗнч(Выборка.ДокументОснование) = Тип("ДокументСсылка.ПередачаСырьяПереработчику")  Тогда
			ПередачаСырьяПереработчику(Выборка, ТипПодключаемойОбработки);
		ИначеЕсли ТипЗнч(Выборка.ДокументОснование) = Тип("ДокументСсылка.ПередачаДавальцу")  Тогда
			ПередачаДавальцу(Выборка, ТипПодключаемойОбработки);
		ИначеЕсли ТипЗнч(Выборка.ДокументОснование) = Тип("ДокументСсылка.ВозвратСырьяДавальцу")  Тогда
			ВозвратСырьяДавальцу(Выборка, ТипПодключаемойОбработки);
		ИначеЕсли ТипЗнч(Выборка.ДокументОснование) = Тип("ДокументСсылка.ОтгрузкаТоваровСХранения")  Тогда
			ОтгрузкаТоваровСХранения(Выборка, ТипПодключаемойОбработки);
		КонецЕсли; 
	КонецЦикла;
	
КонецФункции

Функция РеализацияТоваровУслуг(Выборка, ТипПодключаемойОбработки)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Выборка.ДокументОснование);
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	РеализацияТоваровУслуг.Номер КАК Номер,
		|	РеализацияТоваровУслуг.Дата КАК Дата,
		|	РеализацияТоваровУслуг.ПометкаУдаления КАК ПометкаУдаления,
		|	ПОДСТРОКА(РеализацияТоваровУслуг.Комментарий, 1, 1000) КАК Комментарий
		|ИЗ
		|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		|ГДЕ
		|	РеализацияТоваровУслуг.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	РеализацияТоваровУслугТовары.Номенклатура.Код КАК НоменклатураКод,
		|	РеализацияТоваровУслугТовары.Номенклатура.Наименование КАК НоменклатураНаименование,
		|	РеализацияТоваровУслугТовары.Номенклатура.ЕдиницаИзмерения.Наименование КАК НоменклатураЕдиницаИзмеренияНаименование,
		|	РеализацияТоваровУслугТовары.Сумма КАК Сумма,
		|	РеализацияТоваровУслугТовары.Количество КАК Количество,
		|	РеализацияТоваровУслугТовары.Количество * РеализацияТоваровУслугТовары.Номенклатура.ЕдиницаИзмерения.Вес КАК НоменклатураЕдиницаИзмеренияВес,
		|	РеализацияТоваровУслугТовары.Номенклатура.ВесЕдиницаИзмерения.Наименование КАК НоменклатураВесЕдиницаИзмеренияНаименование
		|ИЗ
		|	Документ.РеализацияТоваровУслуг.Товары КАК РеализацияТоваровУслугТовары
		|ГДЕ
		|	РеализацияТоваровУслугТовары.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	Шапка = РезультатЗапроса[0].Выбрать();
	Шапка.Следующий();
	Грузы  = РезультатЗапроса[1].Выбрать();
	
	ВыгрузитьВСАКВТ(Выборка, Шапка, Грузы, ТипПодключаемойОбработки);
	
КонецФункции

Функция ВозвратТоваровПоставщику(Выборка, ТипПодключаемойОбработки)

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Выборка.ДокументОснование);
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ВозвратТоваровПоставщику.Номер КАК Номер,
		|	ВозвратТоваровПоставщику.Дата КАК Дата,
		|	ВозвратТоваровПоставщику.ПометкаУдаления КАК ПометкаУдаления,
		|	ПОДСТРОКА(ВозвратТоваровПоставщику.Комментарий, 1, 1000) КАК Комментарий
		|ИЗ
		|	Документ.ВозвратТоваровПоставщику КАК ВозвратТоваровПоставщику
		|ГДЕ
		|	ВозвратТоваровПоставщику.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВозвратТоваровПоставщикуТовары.Номенклатура.Код КАК НоменклатураКод,
		|	ВозвратТоваровПоставщикуТовары.Номенклатура.Наименование КАК НоменклатураНаименование,
		|	ВозвратТоваровПоставщикуТовары.Номенклатура.ЕдиницаИзмерения.Наименование КАК НоменклатураЕдиницаИзмеренияНаименование,
		|	ВозвратТоваровПоставщикуТовары.Сумма КАК Сумма,
		|	ВозвратТоваровПоставщикуТовары.Количество КАК Количество,
		|	ВозвратТоваровПоставщикуТовары.Количество * ВозвратТоваровПоставщикуТовары.Номенклатура.ЕдиницаИзмерения.Вес КАК НоменклатураЕдиницаИзмеренияВес,
		|	ВозвратТоваровПоставщикуТовары.Номенклатура.ВесЕдиницаИзмерения.Наименование КАК НоменклатураВесЕдиницаИзмеренияНаименование
		|ИЗ
		|	Документ.ВозвратТоваровПоставщику.Товары КАК ВозвратТоваровПоставщикуТовары
		|ГДЕ
		|	ВозвратТоваровПоставщикуТовары.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	Шапка = РезультатЗапроса[0].Выбрать();
	Шапка.Следующий();
	Грузы  = РезультатЗапроса[1].Выбрать();
	
	ВыгрузитьВСАКВТ(Выборка, Шапка, Грузы, ТипПодключаемойОбработки);

КонецФункции // ()

Функция ПередачаСырьяПереработчику(Выборка, ТипПодключаемойОбработки)

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Выборка.ДокументОснование);
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ПередачаСырьяПереработчику.Номер КАК Номер,
		|	ПередачаСырьяПереработчику.Дата КАК Дата,
		|	ПередачаСырьяПереработчику.ПометкаУдаления КАК ПометкаУдаления,
		|	ПОДСТРОКА(ПередачаСырьяПереработчику.Комментарий, 1, 1000) КАК Комментарий
		|ИЗ
		|	Документ.ПередачаСырьяПереработчику КАК ПередачаСырьяПереработчику
		|ГДЕ
		|	ПередачаСырьяПереработчику.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ПередачаСырьяПереработчикуТовары.Номенклатура.Код КАК НоменклатураКод,
		|	ПередачаСырьяПереработчикуТовары.Номенклатура.Наименование КАК НоменклатураНаименование,
		|	ПередачаСырьяПереработчикуТовары.Номенклатура.ЕдиницаИзмерения.Наименование КАК НоменклатураЕдиницаИзмеренияНаименование,
		|	ПередачаСырьяПереработчикуТовары.Сумма КАК Сумма,
		|	ПередачаСырьяПереработчикуТовары.Количество КАК Количество,
		|	ПередачаСырьяПереработчикуТовары.Количество * ПередачаСырьяПереработчикуТовары.Номенклатура.ЕдиницаИзмерения.Вес КАК НоменклатураЕдиницаИзмеренияВес,
		|	ПередачаСырьяПереработчикуТовары.Номенклатура.ВесЕдиницаИзмерения.Наименование КАК НоменклатураВесЕдиницаИзмеренияНаименование
		|ИЗ
		|	Документ.ПередачаСырьяПереработчику.Товары КАК ПередачаСырьяПереработчикуТовары
		|ГДЕ
		|	ПередачаСырьяПереработчикуТовары.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	Шапка = РезультатЗапроса[0].Выбрать();
	Шапка.Следующий();
	Грузы  = РезультатЗапроса[1].Выбрать();
	
	ВыгрузитьВСАКВТ(Выборка, Шапка, Грузы, ТипПодключаемойОбработки);
	
КонецФункции // ()

Функция ПередачаДавальцу(Выборка, ТипПодключаемойОбработки)

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Выборка.ДокументОснование);
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ПередачаДавальцу.Номер КАК Номер,
		|	ПередачаДавальцу.Дата КАК Дата,
		|	ПередачаДавальцу.ПометкаУдаления КАК ПометкаУдаления,
		|	ПОДСТРОКА(ПередачаДавальцу.Комментарий, 1, 1000) КАК Комментарий
		|ИЗ
		|	Документ.ПередачаДавальцу КАК ПередачаДавальцу
		|ГДЕ
		|	ПередачаДавальцу.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ПередачаДавальцуТовары.Номенклатура.Код КАК НоменклатураКод,
		|	ПередачаДавальцуТовары.Номенклатура.Наименование КАК НоменклатураНаименование,
		|	ПередачаДавальцуТовары.Номенклатура.ЕдиницаИзмерения.Наименование КАК НоменклатураЕдиницаИзмеренияНаименование,
		|	ПередачаДавальцуТовары.Сумма КАК Сумма,
		|	ПередачаДавальцуТовары.Количество КАК Количество,
		|	ПередачаДавальцуТовары.Количество * ПередачаДавальцуТовары.Номенклатура.ЕдиницаИзмерения.Вес КАК НоменклатураЕдиницаИзмеренияВес,
		|	ПередачаДавальцуТовары.Номенклатура.ВесЕдиницаИзмерения.Наименование КАК НоменклатураВесЕдиницаИзмеренияНаименование
		|ИЗ
		|	Документ.ПередачаДавальцу.Товары КАК ПередачаДавальцуТовары
		|ГДЕ
		|	ПередачаДавальцуТовары.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	Шапка = РезультатЗапроса[0].Выбрать();
	Шапка.Следующий();
	Грузы  = РезультатЗапроса[1].Выбрать();
	
	ВыгрузитьВСАКВТ(Выборка, Шапка, Грузы, ТипПодключаемойОбработки);

КонецФункции // ()

Функция ВозвратСырьяДавальцу(Выборка, ТипПодключаемойОбработки)

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Выборка.ДокументОснование);
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ВозвратСырьяДавальцу.Номер КАК Номер,
		|	ВозвратСырьяДавальцу.Дата КАК Дата,
		|	ВозвратСырьяДавальцу.ПометкаУдаления КАК ПометкаУдаления,
		|	ПОДСТРОКА(ВозвратСырьяДавальцу.Комментарий, 1, 1000) КАК Комментарий
		|ИЗ
		|	Документ.ВозвратСырьяДавальцу КАК ВозвратСырьяДавальцу
		|ГДЕ
		|	ВозвратСырьяДавальцу.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВозвратСырьяДавальцуТовары.Номенклатура.Код КАК НоменклатураКод,
		|	ВозвратСырьяДавальцуТовары.Номенклатура.Наименование КАК НоменклатураНаименование,
		|	ВозвратСырьяДавальцуТовары.Номенклатура.ЕдиницаИзмерения.Наименование КАК НоменклатураЕдиницаИзмеренияНаименование,
		|	ВозвратСырьяДавальцуТовары.Сумма КАК Сумма,
		|	ВозвратСырьяДавальцуТовары.Количество КАК Количество,
		|	ВозвратСырьяДавальцуТовары.Количество * ВозвратСырьяДавальцуТовары.Номенклатура.ЕдиницаИзмерения.Вес КАК НоменклатураЕдиницаИзмеренияВес,
		|	ВозвратСырьяДавальцуТовары.Номенклатура.ВесЕдиницаИзмерения.Наименование КАК НоменклатураВесЕдиницаИзмеренияНаименование
		|ИЗ
		|	Документ.ВозвратСырьяДавальцу.Товары КАК ВозвратСырьяДавальцуТовары
		|ГДЕ
		|	ВозвратСырьяДавальцуТовары.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	Шапка = РезультатЗапроса[0].Выбрать();
	Шапка.Следующий();
	Грузы  = РезультатЗапроса[1].Выбрать();
	
	ВыгрузитьВСАКВТ(Выборка, Шапка, Грузы, ТипПодключаемойОбработки);
	
КонецФункции // ()

Функция ОтгрузкаТоваровСХранения(Выборка, ТипПодключаемойОбработки)

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Выборка.ДокументОснование);
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ОтгрузкаТоваровСХранения.Номер КАК Номер,
		|	ОтгрузкаТоваровСХранения.Дата КАК Дата,
		|	ОтгрузкаТоваровСХранения.ПометкаУдаления КАК ПометкаУдаления,
		|	ПОДСТРОКА(ОтгрузкаТоваровСХранения.Комментарий, 1, 1000) КАК Комментарий
		|ИЗ
		|	Документ.ОтгрузкаТоваровСХранения КАК ОтгрузкаТоваровСХранения
		|ГДЕ
		|	ОтгрузкаТоваровСХранения.Ссылка = &Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ОтгрузкаТоваровСХраненияТовары.Номенклатура.Код КАК НоменклатураКод,
		|	ОтгрузкаТоваровСХраненияТовары.Номенклатура.Наименование КАК НоменклатураНаименование,
		|	ОтгрузкаТоваровСХраненияТовары.Номенклатура.ЕдиницаИзмерения.Наименование КАК НоменклатураЕдиницаИзмеренияНаименование,
		|	ОтгрузкаТоваровСХраненияТовары.Сумма КАК Сумма,
		|	ОтгрузкаТоваровСХраненияТовары.Количество КАК Количество,
		|	ОтгрузкаТоваровСХраненияТовары.Количество * ОтгрузкаТоваровСХраненияТовары.Номенклатура.ЕдиницаИзмерения.Вес КАК НоменклатураЕдиницаИзмеренияВес,
		|	ОтгрузкаТоваровСХраненияТовары.Номенклатура.ВесЕдиницаИзмерения.Наименование КАК НоменклатураВесЕдиницаИзмеренияНаименование
		|ИЗ
		|	Документ.ОтгрузкаТоваровСХранения.Товары КАК ОтгрузкаТоваровСХраненияТовары
		|ГДЕ
		|	ОтгрузкаТоваровСХраненияТовары.Ссылка = &Ссылка";
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	Шапка = РезультатЗапроса[0].Выбрать();
	Шапка.Следующий();
	Грузы  = РезультатЗапроса[1].Выбрать();
	
	ВыгрузитьВСАКВТ(Выборка, Шапка, Грузы, ТипПодключаемойОбработки);

КонецФункции // ()

Функция ВыгрузитьВСАКВТ(Выборка, Шапка, Грузы, ТипПодключаемойОбработки, Отказ = Ложь)
	
	ДвоичныеДанные = ТипПодключаемойОбработки.СхемаXSD.Получить();
	Если Не ДвоичныеДанные = Неопределено Тогда
		ИмяВременногоФайла = ПолучитьИмяВременногоФайла(".xsd");
		ДвоичныеДанные.Записать(ИмяВременногоФайла);
		врФабрикаXDTO = СоздатьФабрикуXDTO(ИмяВременногоФайла);
	Иначе
		врФабрикаXDTO = ФабрикаXDTO;
	КонецЕсли; 
	
	root 			= врФабрикаXDTO.Создать(врФабрикаXDTO.Тип("http://aem_askvt", "root"));   	
	document 		= врФабрикаXDTO.Создать(врФабрикаXDTO.Тип("http://aem_askvt", "document"));   	
	title 			= врФабрикаXDTO.Создать(врФабрикаXDTO.Тип("http://aem_askvt", "title"));   	
	rows 			= врФабрикаXDTO.Создать(врФабрикаXDTO.Тип("http://aem_askvt", "rows"));   	
	organization    = врФабрикаXDTO.Создать(врФабрикаXDTO.Тип("http://aem_askvt", "client"));  
	consignee		= врФабрикаXDTO.Создать(врФабрикаXDTO.Тип("http://aem_askvt", "client"));  
	contractor		= врФабрикаXDTO.Создать(врФабрикаXDTO.Тип("http://aem_askvt", "client"));  
	shipper			= врФабрикаXDTO.Создать(врФабрикаXDTO.Тип("http://aem_askvt", "client"));  
	car				= врФабрикаXDTO.Создать(врФабрикаXDTO.Тип("http://aem_askvt", "car"));  
	
	Сч 	 = 0;
	Пока Грузы.Следующий() Цикл
		nomenclature 	  = врФабрикаXDTO.Создать(врФабрикаXDTO.Тип("http://aem_askvt", "nomenclature"));  
		nomenclature.id   = XMLСтрока(Грузы.НоменклатураКод);
		nomenclature.name = XMLСтрока(Грузы.НоменклатураНаименование);
		nomenclature.quantity_unit = XMLСтрока(Грузы.НоменклатураЕдиницаИзмеренияНаименование);
		nomenclature.weight_unit   = XMLСтрока(Грузы.НоменклатураВесЕдиницаИзмеренияНаименование);
		row		 		= врФабрикаXDTO.Создать(врФабрикаXDTO.Тип("http://aem_askvt", "row"));  
		//row.id 				=
		row.nomenclature 	= nomenclature;
		row.quantity 		= Грузы.Количество;
		row.summ 	 		= Грузы.Сумма;
		//row.tare
		row.weight		    = Грузы.НоменклатураЕдиницаИзмеренияВес;
		rows.row.Добавить(row);
	КонецЦикла;
	
	// авто
	car.id			= XMLСтрока(Выборка.АвтомобильГосударственныйНомер);
	car.driver  	= XMLСтрока(Выборка.Водитель);
	car.mark    	= XMLСтрока(Выборка.АвтомобильМарка);
	car.trailer_id 	= XMLСтрока(Выборка.Прицеп);
	
	// organization.id  	= не заполняется 
	organization.inn    = XMLСтрока(Выборка.ОрганизацияИНН);
	organization.kpp    = XMLСтрока(Выборка.ОрганизацияКПП);
	organization.name   = XMLСтрока(Выборка.ОрганизацияНаименование);
	
	// грузополучатель
	consignee.inn 	   = XMLСтрока(Выборка.ГрузополучательИНН);
	consignee.kpp	   = XMLСтрока(Выборка.ГрузополучательКПП);
	consignee.name     = XMLСтрока(Выборка.ГрузополучательНаименование);
	
	// плательщик
	contractor.inn 	   = XMLСтрока(Выборка.ПлательщикИНН);
	contractor.kpp	   = XMLСтрока(Выборка.ПлательщикКПП);
	contractor.name    = XMLСтрока(Выборка.ПлательщикНаименование);
	
	// перевозчик
	shipper.inn 	   = XMLСтрока(Выборка.ПеревозчикИНН);
	shipper.kpp		   = XMLСтрока(Выборка.ПеревозчикКПП);
	shipper.name       = XMLСтрока(Выборка.ПеревозчикНаименование);
	
	title.car 			= car;
	title.organization 	= organization;
	title.consignee 	= consignee;
	title.contractor 	= contractor;
	title.shipper 		= shipper;
	title.comment    	= XMLСтрока(Шапка.Комментарий); // Шапка
	
	//document.delete 	= ?(Шапка.ПометкаУдаления,1,0); // Шапка // пометка удаления документа-основания
	Если Строка(ТипПодключаемойОбработки) = "Отзыв транспортной накладной из АСКВТ" Тогда
	  document.delete 	= 1;
  	Иначе
	  document.delete 	= 0;
	КонецЕсли; 
	
	document.datetime	= Шапка.Дата;                   // Шапка
	document.number     = XMLСтрока(Шапка.Номер);       // Шапка
	
	document.uid		= Выборка.Ссылка.УникальныйИдентификатор(); // так написано в чтз № 2
	document.rows     	= rows;
	document.title		= title;
	
	root.document     	= document;
	root.datetime		= ТекущаяДатаСеанса();

	//ТТН на вывоз ТМЦ	01
	//ТТН на ввоз ТМЦ	02
	//ТТН на ввоз ТМЦ с последующим вывозом	03
	//ТТН на отгрузку ж/д	16
	document.type      = "01"; // ТТН на вывоз ТМЦ

	ХМЛ = wsОбработчики.XDTOtoXML(root);
	
	// чистим простансnва имен, с ними некорректно работает раpбор ХМЛ с помощью ХPATH в АСКВТ...
	ХМЛ = СтрЗаменить(ХМЛ, "xmlns=""http://aem_askvt""", "");
	ХМЛ = СтрЗаменить(ХМЛ, "xmlns:xs=""http://www.w3.org/2001/XMLSchema""", "");
	ХМЛ = СтрЗаменить(ХМЛ, "xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""", "");
	
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
		Результат = Прокси.exchange(Новый ХранилищеЗначения(ХМЛ), "АВТО"); // тип = АВТО, ЖД, договорились, что всегда "АВТО"
		Если Результат Тогда
			Сообщить("Готово.");
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
							Выборка.Ссылка, Истина); // обработано
	
	КонецЕсли; 
	
КонецФункции // ()
