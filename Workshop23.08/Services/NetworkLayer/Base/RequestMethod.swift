//
//  RequestMethod.swift
//  Partyshaker
//
//  Created by Alexandr Rodionov on 13.05.23.
//
/*
 `RequestMethod` - это перечисление (enum), определяющее HTTP методы, которые могут быть использованы при отправке HTTP запросов. В данном случае перечислены следующие методы:
 
 1. `GET` - Используется для запроса данных от указанного ресурса. Не вносит изменений и предназначен только для получения данных.
 2. `POST` - Используется для отправки данных на сервер для создания нового ресурса.
 3. `PUT` - Используется для обновления существующего ресурса на сервере.
 4. `DELETE` - Используется для удаления указанного ресурса.
 5. `PATCH` - Используется для частичного обновления ресурса.
 
 Эти методы - основные методы HTTP, используемые в API для выполнения различных операций.
 
 Каждому методу присваивается соответствующее строковое значение, что позволяет легко преобразовать его в строку при формировании HTTP запроса.
 */

import Foundation

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
