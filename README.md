# norrisApp

NorrisApp é uma aplicação que tem como objetivo de ser uma aplicação iOS simples e sem dependências.
A aplicação utiliza a: **[chucknorris.io](https://api.chucknorris.io/)** uma API grátis que contém fatos do Chuck Norris ✊

## Arquitetura

|| Divisão               |Responsabilidade      |Testado com                         |
|-|----------------|-------------------------------|-----------------------------|
|1º|Network|Requisições URLSession           |XCTest           |
|2º|Business          |Parse do response obtido            |XCTest            |
|3º|Manager          |Lógica do ViewController|XCTest
|4º|View          |ViewController, área visual|XCUITtest
