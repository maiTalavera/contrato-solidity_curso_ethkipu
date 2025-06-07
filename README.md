# Contrato Solidity - Curso ETH Kipu

## Descripción

Contrato inteligente desarrollado en Solidity como parte del curso de Ethereum de Kipu.  
El contrato permite guardar un mensaje y recuperarlo. Además, emite un evento cuando el mensaje es actualizado.

## Dirección del contrato desplegado

`0xcb00386e8937a9c2a7739e9b7cf8fdc44b3efa83`  
👉 [Ver en Sepolia Etherscan](https://sepolia.etherscan.io/address/0xcb00386e8937a9c2a7739e9b7cf8fdc44b3efa83)

## Variables

```solidity
string private message;
address public owner;

## Herramientas utilizadas

- Solidity
- Remix IDE
- Red de prueba Sepolia
- MetaMask

## Funciones del contrato
message: almacena el mensaje actual.
owner: dirección de la cuenta que desplegó el contrato.

solidity
Copiar
Editar
function setMessage(string memory newMessage) public;
function getMessage() public view returns (string memory);
setMessage: permite actualizar el mensaje. Emite un evento cuando se actualiza.
getMessage: devuelve el mensaje actual almacenado.

Eventos
solidity
Copiar
Editar
event MessageUpdated(string newMessage);
MessageUpdated: se emite cada vez que se actualiza el mensaje.

Requisitos para correr el proyecto
MetaMask (opcional para interactuar con el contrato desde la web)
Una wallet con ETH en la testnet Sepolia

## Autor
Maira Antonella Talavera
Curso Ethereum - Kipu 2025
