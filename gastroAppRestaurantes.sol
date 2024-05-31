// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

import "./gastroAppFuncoes.sol";

contract RestauranteApp is FuncoesApp{

    //==================================\\
    //       { comprarPerfil }           ||
    //==================================//

    function comprarPerfil() public payable returns(bool) {
        require(msg.value == valorPerfil, "saldo Insuficiente");
        donoPerfil = msg.sender;
        return perfilComprado = true;
    }

    mapping(string => Prato) public pratos;
    mapping(string => Bebida) public bebidas;


    function PerfilRestaurante(string memory _nome, string memory _foto, string memory _categoria, string memory _bio, string memory _linkExterno, uint _nascimento) external {
        add5Fotos(_foto);
        EditarPerfil(_nome, _foto, _categoria, _bio, _linkExterno, _nascimento);
    }

    function criarPrato(string memory _nomePrato, string memory _descricaoPrato, string memory _categoriaPrato, string memory _fotoPrato, uint _valorPrato) public {
        Prato memory _pratos = Prato(_nomePrato, _descricaoPrato, _categoriaPrato, _fotoPrato, _valorPrato);
        pratos[_nomePrato] = _pratos;
    }
    
    function criarBebida(string memory _nomeBebida, string memory _descricaoBebida, string memory _categoriaBebida, string memory _fotoBebida, uint _valorBebida) public {
        Bebida memory _bebida = Bebida(_nomeBebida, _descricaoBebida, _categoriaBebida, _fotoBebida, _valorBebida);
        bebidas[_nomeBebida] = _bebida;
    }

    function Reels(string memory _video) public {
        criarReels(_video);
    }

}