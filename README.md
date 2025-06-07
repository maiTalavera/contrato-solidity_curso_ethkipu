# Contrato Solidity - Curso ETH Kipu

## Descripción
Este contrato implementa una subasta básica en la blockchain, donde los usuarios pueden ofertar por un bien en un período de tiempo determinado.
Se garantiza seguridad en los depósitos, extensión automática de tiempo para evitar sniping, y reembolsos automáticos para los no ganadores.
## Dirección del contrato desplegado

`0xcb00386e8937a9c2a7739e9b7cf8fdc44b3efa83`  
👉 [Ver en Sepolia Etherscan](https://sepolia.etherscan.io/address/0xcb00386e8937a9c2a7739e9b7cf8fdc44b3efa83)


##Variables públicas
address public propietario
Dirección del creador de la subasta (quien despliega el contrato).
uint public tiempoFin
Timestamp (en segundos) cuando finaliza la subasta.
uint public mejorOferta
Valor actual más alto ofertado.
address public mejorOferente
Dirección del participante con la mejor oferta.
bool public subastaFinalizada
Estado de la subasta (activa o finalizada).
mapping(address => uint) public depositos
Depósitos realizados por cada oferente.
Oferta[] public ofertas
Array con el historial completo de las ofertas.
uint public constanteTiempoExtension
Tiempo adicional que se suma si hay una oferta en los últimos 10 minutos.
address oferente → dirección que realiza la oferta.
uint monto → monto ofertado.

## Herramientas utilizadas

- Solidity
- Remix IDE
- Red de prueba Sepolia
- MetaMask

##Eventos
vent NuevaOferta(address indexed oferente, uint monto);
Se emite cada vez que un usuario realiza una oferta válida.
event SubastaFinalizada(address ganador, uint montoGanador);
Se emite cuando el propietario finaliza la subasta y transfiere los fondos.

##Funciones generales
l propietario crea la subasta con una duración determinada.
Los participantes hacen ofertas con ofertar().
Cada oferta debe superar la actual en un mínimo del 5%.
Si la oferta es dentro de los últimos 10 min, se extiende la subasta.
Al finalizar el tiempo, el propietario llama a finalizarSubasta().
El propietario recibe los fondos menos una comisión.
Los no ganadores pueden recuperar su depósito llamando a reembolsarNoGanadores().

##Funciones
constructor(uint _duracionEnMinutos)
Inicializa la subasta:
Define el propietario.
Establece tiempoFin como block.timestamp + duración.
La subasta inicia activa.
function ofertar() external payable soloMientrasActiva
Permite a los usuarios hacer una oferta:
La nueva oferta debe ser al menos 5% mayor que la actual mejor oferta (o ser la primera oferta).
Si el oferente ya había participado, se le reembolsa su depósito anterior.
Se actualiza mejorOferta y mejorOferente.Si la oferta ocurre en los últimos 10 minutos de la subasta, se extiende el tiempo automáticamente.
Se registra la oferta en el array ofertas y se emite NuevaOferta.
function finalizarSubasta() external soloPropietario
Permite al propietario finalizar la subasta después de tiempoFin:
Marca la subasta como finalizada.
Calcula y transfiere el monto al propietario (descontando una comisión del 2%).
Emite el evento SubastaFinalizada.
function reembolsarNoGanadores() external
Permite a los participantes que no ganaron recuperar su depósito:
Solo se puede usar después de que la subasta ha finalizado.
El ganador NO puede usar esta función.
Se transfiere el depósito completo de vuelta al oferente.
function obtenerGanador() external view returns (address, uint)
Devuelve:
La dirección del mejorOferente.
El monto de la mejorOferta.
function obtenerOfertas() external view returns (Oferta[] memory)
Devuelve la lista completa de todas las ofertas realizadas durante la subasta.


Requisitos para correr el proyecto
MetaMask (opcional para interactuar con el contrato desde la web)
Una wallet con ETH en la testnet Sepolia

## Autor
Maira Antonella Talavera
Curso Ethereum - Kipu 2025
