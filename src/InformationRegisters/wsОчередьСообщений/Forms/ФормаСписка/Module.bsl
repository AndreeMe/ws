
&НаСервере
Процедура ОбработатьЗаписиНаСервере()
	wsОбработчики.ОбработкаОчередиСообщений();
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьЗаписи(Команда)
	ОбработатьЗаписиНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОбработатьЗаписьНаСервере(IDСообщения)
	СообщениеОбОшибке = wsОбработчики.ОбработатьСообщение(IDСообщения);
	Если ЗначениеЗаполнено(СообщениеОбОшибке) Тогда
		Сообщить(СообщениеОбОшибке);
	КонецЕсли; 
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьЗапись(Команда)
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если Не ТекущиеДанные = Неопределено Тогда
		ОбработатьЗаписьНаСервере(ТекущиеДанные.IDСообщения);
	КонецЕсли; 
КонецПроцедуры
