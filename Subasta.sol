// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.26;

contract Subasta {

    struct Oferta {
        address oferente;
        uint monto;
    }

    address public propietario;
    uint public tiempoFin;
    uint public mejorOferta;
    address public mejorOferente;
    bool public subastaFinalizada;

    mapping(address => uint) public depositos;
    Oferta[] public ofertas;

    uint public constanteTiempoExtension = 10 minutes;

    event NuevaOferta(address indexed oferente, uint monto);
    event SubastaFinalizada(address ganador, uint montoGanador);

    modifier soloMientrasActiva() {
        require(block.timestamp < tiempoFin, "La subasta ha finalizado.");
        require(!subastaFinalizada, "La subasta ya fue finalizada.");
        _;
    }

    modifier soloPropietario() {
        require(msg.sender == propietario, "Solo el propietario puede ejecutar esta funcion.");
        _;
    }

    constructor(uint _duracionEnMinutos) {
        propietario = msg.sender;
        tiempoFin = block.timestamp + (_duracionEnMinutos * 1 minutes);
    }

    function ofertar() external payable soloMientrasActiva {
        require(msg.value >= (mejorOferta * 105) / 100 || mejorOferta == 0, "La oferta debe ser al menos 5% mayor que la actual.");

        // Reembolso parcial permitido:
        if (depositos[msg.sender] > 0) {
            uint reembolso = depositos[msg.sender];
            payable(msg.sender).transfer(reembolso);
            depositos[msg.sender] = 0;
        }

        // Registrar nueva oferta
        depositos[msg.sender] += msg.value;
        mejorOferta = depositos[msg.sender];
        mejorOferente = msg.sender;

        ofertas.push(Oferta({
            oferente: msg.sender,
            monto: depositos[msg.sender]
        }));

        // Extender tiempo si oferta dentro de ultimos 10 minutos
        if (tiempoFin - block.timestamp <= 10 minutes) {
            tiempoFin += constanteTiempoExtension;
        }

        emit NuevaOferta(msg.sender, msg.value);
    }

    function finalizarSubasta() external soloPropietario {
        require(block.timestamp >= tiempoFin, "La subasta sigue activa.");
        require(!subastaFinalizada, "La subasta ya fue finalizada.");

        subastaFinalizada = true;

        uint comision = (mejorOferta * 2) / 100;
        uint montoPropietario = mejorOferta - comision;

        // Transferir monto al propietario
        payable(propietario).transfer(montoPropietario);

        emit SubastaFinalizada(mejorOferente, mejorOferta);
    }

    function reembolsarNoGanadores() external {
        require(subastaFinalizada, "La subasta no ha finalizado.");

        require(msg.sender != mejorOferente, "El ganador no puede reembolsar.");

        uint monto = depositos[msg.sender];
        require(monto > 0, "No hay deposito para reembolsar.");

        depositos[msg.sender] = 0;
        payable(msg.sender).transfer(monto);
    }

    function obtenerGanador() external view returns (address, uint) {
        return (mejorOferente, mejorOferta);
    }

    function obtenerOfertas() external view returns (Oferta[] memory) {
        return ofertas;
    }
}
