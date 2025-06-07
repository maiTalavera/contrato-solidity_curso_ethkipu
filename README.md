# Contrato Solidity - Curso Ethereum Kipu

Este es un contrato inteligente creado como parte del curso de Ethereum de Kipu.

## Descripción

El contrato es un token que permite:

- Crear un token.
- Transferir tokens entre cuentas.
- Consultar el balance.

## Herramientas utilizadas

- Solidity
- Remix IDE
- Red de prueba Sepolia
- MetaMask

## Despliegue

El contrato fue desplegado en la red de prueba Sepolia con la siguiente dirección:

`0xcb00386e8937a9c2a7739e9b7cf8fdc44b3efa83`

## Funciones del contrato

- `totalSupply() public view returns (uint256)`  
  Devuelve la cantidad total de tokens existentes.

- `balanceOf(address account) public view returns (uint256)`  
  Devuelve el balance de tokens de una cuenta.

- `transfer(address recipient, uint256 amount) public returns (bool)`  
  Transfiere tokens del emisor al destinatario.

- `allowance(address owner, address spender) public view returns (uint256)`  
  Devuelve la cantidad de tokens que un `spender` está autorizado a gastar en nombre del `owner`.

- `approve(address spender, uint256 amount) public returns (bool)`  
  Autoriza a un `spender` a gastar una cantidad específica de tokens en nombre del emisor.

- `transferFrom(address sender, address recipient, uint256 amount) public returns (bool)`  
  Permite a un `spender` transferir tokens desde la cuenta de un `owner` a otra cuenta.

## Variables del contrato

- `string public name`  
  Nombre del token 

- `string public symbol`  
  Símbolo del token 

- `uint8 public decimals`  
  Número de decimales que utiliza el token (por defecto 18).

- `uint256 public totalSupply`  
  Total de tokens creados.

- `mapping(address => uint256) private balances`  
  Mapeo que lleva el control de los balances de cada cuenta.

- `mapping(address => mapping(address => uint256)) private allowances`  
  Mapeo que gestiona las autorizaciones.

## Eventos del contrato

- `event Transfer(address indexed from, address indexed to, uint256 value)`  
  Se emite cuando se transfiere un token.

- `event Approval(address indexed owner, address indexed spender, uint256 value)`  
  Se emite cuando se aprueba a un `spender` para gastar tokens.


## Autor

Maira Antonella Talavera
