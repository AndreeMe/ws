Функция ping()
	Возврат Истина;
КонецФункции

Функция LoadIncomingMaterials(Сообщение)
	УстановитьПривилегированныйРежим(Истина);
	
	ТипСообщения = Справочники.wsТипыСообщений.НайтиПоНаименованию("LoadIncomingMaterials");
	
	wsОбработчики.ЗаписатьСообщениеВОчередьСообщений(Сообщение, ТипСообщения, Перечисления.wsНаправлениеСообщения.Входящее); 
	
	ПараметрыФоновогоЗадания = Новый Массив;
	ФоновыеЗадания.Выполнить("wsОбработчики.ОбработкаОчередиСообщений",
				ПараметрыФоновогоЗадания, Новый УникальныйИдентификатор, "Обработка очереди сообщений""");
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Истина;
КонецФункции

Функция LoadActualWeight(Сообщение)
	УстановитьПривилегированныйРежим(Истина);
	
	ТипСообщения = Справочники.wsТипыСообщений.НайтиПоНаименованию("LoadActualWeight");
	
	wsОбработчики.ЗаписатьСообщениеВОчередьСообщений(Сообщение, ТипСообщения, Перечисления.wsНаправлениеСообщения.Входящее); 
	
	ПараметрыФоновогоЗадания = Новый Массив;
	ФоновыеЗадания.Выполнить("wsОбработчики.ОбработкаОчередиСообщений",
				ПараметрыФоновогоЗадания, Новый УникальныйИдентификатор, "Обработка очереди сообщений""");
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Истина;
КонецФункции

Функция LoadKaz(Сообщение)
	УстановитьПривилегированныйРежим(Истина);
	
	ТипСообщения = Справочники.wsТипыСообщений.НайтиПоНаименованию("Выгрузка КАЗ в ЕРП");
	
	// здесь сообщение запаковано
	
	
	Сообщение = Сообщение.Получить();
	
	wsОбработчики.ЗаписатьСообщениеВОчередьСообщений(Сообщение, ТипСообщения, Перечисления.wsНаправлениеСообщения.Входящее); 
	
	ПараметрыФоновогоЗадания = Новый Массив;
	ФоновыеЗадания.Выполнить("wsОбработчики.ОбработкаОчередиСообщений",
				ПараметрыФоновогоЗадания, Новый УникальныйИдентификатор, "Обработка очереди сообщений""");
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Истина;
КонецФункции

Функция LoadProdactionOrderConfirmation(Сообщение)
	
	УстановитьПривилегированныйРежим(Истина);
	
	ТипСообщения = Справочники.wsТипыСообщений.НайтиПоНаименованию("Подтверждение производственного заказа из ЭКК");
	
	Сообщение = Сообщение.Получить();
	
	wsОбработчики.ЗаписатьСообщениеВОчередьСообщений(Сообщение, ТипСообщения, Перечисления.wsНаправлениеСообщения.Входящее); 
	
	ПараметрыФоновогоЗадания = Новый Массив;
	ФоновыеЗадания.Выполнить("wsОбработчики.ОбработкаОчередиСообщений",
				ПараметрыФоновогоЗадания, Новый УникальныйИдентификатор, "Обработка очереди сообщений""");
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Истина;
КонецФункции


