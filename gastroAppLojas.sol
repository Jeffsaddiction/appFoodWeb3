// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "./gastroAppFuncoes.sol";

contract lojasApp is FuncoesApp {

    //==================================\\
    //    { comprarPerfil }  WEB3        ||
    //==================================//

    function comprarPerfil() public payable returns(bool) {
        require(msg.value == valorPerfil, "saldo Insuficiente");
        donoPerfil = msg.sender;
        return perfilComprado = true;
    }

    //==================================\\
    //  { INVENTARIO DE PRODUTOS } web3  ||
    //==================================//
    struct dadosSimilares {
        string nomeProduto;
        string tipoProduto;
        string descricao;
        uint validade;
        uint valor;
        uint quantidade;
    }

    //======================================\\
    //   { INVENTARIO DE BEBIDAS/COMIDAS }   ||
    //======================================//
    event BebidaAdicionada(string nomeProduto, uint quantidade);
    event AlimentoAdicionado(string nomeProduto, uint quantidade);
    event alimentoVendido(string _nomeProduto, uint _quantidade);

    struct Bebidas {
        dadosSimilares dadosBebidas;
    }

    struct Alimentos {
        dadosSimilares dadosAlimentos;
    }
    
    mapping(string => Bebidas) private mapBebidas;
    mapping(string => Alimentos) private mapAlimentos;
    mapping(string => uint) private estoque;

    function estoqueBebidas(string memory _nomeProduto) public view returns(string memory, string memory, string memory, uint, uint, uint) {
        Bebidas memory produto = mapBebidas[_nomeProduto];
        return (
            produto.dadosBebidas.nomeProduto,
            produto.dadosBebidas.tipoProduto,
            produto.dadosBebidas.descricao,
            produto.dadosBebidas.validade,
            produto.dadosBebidas.valor,
            produto.dadosBebidas.quantidade
        );
    }

    function estoqueAlimentos(string memory _nomeProduto) public view returns (string memory, string memory, string memory, uint, uint, uint) {
        Alimentos memory produto = mapAlimentos[_nomeProduto];
        return (
            produto.dadosAlimentos.nomeProduto,
            produto.dadosAlimentos.tipoProduto,
            produto.dadosAlimentos.descricao,
            produto.dadosAlimentos.validade,
            produto.dadosAlimentos.valor,
            produto.dadosAlimentos.quantidade
        );
    }

    //=======================================\\
    //               { LOJA }      WEB        ||
    //=======================================//

    function criarPerfilLoja(string memory _nome, string memory _bio, string memory _tipo, string memory _foto, string memory _linkExterno, uint _idade) public donoPerfilmod() {
        require(perfilComprado == true, "nenhum perfil comprado");
        EditarPerfil(_nome, _bio, _tipo, _foto, _linkExterno, _idade);
    }

    //=======================================\\
    //               { BEBIDAS }    WEB2      ||
    //=======================================//

    function addbebidas(string memory _nomeProduto, string memory _tipoProduto, string memory _descricao, uint _validade, uint _valor, uint _quantidade) public donoPerfilmod() {
        dadosSimilares memory dados = dadosSimilares(_nomeProduto, _tipoProduto, _descricao, _validade, _valor, _quantidade);
        Bebidas memory newMapaBebida = Bebidas(dados);
        mapBebidas[_nomeProduto] = newMapaBebida;
        estoque[_nomeProduto] += _quantidade;
        emit BebidaAdicionada(_nomeProduto, _quantidade);
    }

    function venderBebida(string memory _nomeProduto, uint _quantidade) public donoPerfilmod() {
        require(mapBebidas[_nomeProduto].dadosBebidas.quantidade >= _quantidade, "Quantidade insuficiente em estoque");
        mapBebidas[_nomeProduto].dadosBebidas.quantidade -= _quantidade;
        estoque[_nomeProduto] -= _quantidade;
        if (mapBebidas[_nomeProduto].dadosBebidas.quantidade == 0) {
            delete mapBebidas[_nomeProduto];
        }
    }

    //=======================================\\
    //               { COMIDAS }  WEB2        ||
    //=======================================//

    function addAlimento(string memory _nomeProduto, string memory _tipoProduto, string memory _descricao, uint _validade, uint _valor, uint _quantidade) public donoPerfilmod() {
        dadosSimilares memory _dados = dadosSimilares(_nomeProduto, _tipoProduto, _descricao, _validade, _valor, _quantidade);
        Alimentos memory NewMapAlimentos = Alimentos(_dados);
        mapAlimentos[_nomeProduto] = NewMapAlimentos;
        estoque[_nomeProduto] += _quantidade;
        emit AlimentoAdicionado(_nomeProduto, _quantidade);
    }

    function venderAlimento(string memory _nomeProduto, uint _quantidade) public donoPerfilmod() {
        require(mapAlimentos[_nomeProduto].dadosAlimentos.quantidade >= _quantidade, "Quantidade insuficiente em estoque");
        mapAlimentos[_nomeProduto].dadosAlimentos.quantidade -= _quantidade;
        if (mapAlimentos[_nomeProduto].dadosAlimentos.quantidade == 0) {
            delete mapAlimentos[_nomeProduto];
        }
        emit alimentoVendido(_nomeProduto, _quantidade);
    }
}


