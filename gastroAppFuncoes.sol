// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract FuncoesApp {

//=================================\\
//     { VARIAVEIS }                ||
//=================================//
    address internal donoPerfil;
    string internal hashVideo;
    uint internal timestamp;
    uint256 ultimoPost;
    uint internal valorPerfil = 10 wei;
    bool public perfilComprado = false;

//================================\\
//    { DADOS DE CONTATO }         ||
//================================//
    struct DadosContato {
        string end;
        string site;
        string emailContato;
    }

    struct CriarEnd {
        string rua;
        string bairro;
        string cidade;
        string estado;
        uint num;
        uint cep;
    }

//=================================\\
//       { MODIFICADORES }          ||
//=================================//

modifier donoPerfilmod() {
    require(msg.sender == donoPerfil, "somente o dono pode chamar essa funcao");
    _;
}

//=================================\\
// { ESTRUTURA PADRÃO PARA PERIS }  ||
//=================================//
    struct Perfil {
        string dado1;  //nome
        string dado2;  //foto
        string dado3;  //genero, tipo...
        string dado4;  //site, rede social, link externo...
        string dado5;  //bio, descrição...
        uint dado6;    // data de nascimento, ano de criação, idade...
    }
//==================================\\
//    { ESTRUTURA DE ALIMENTOS }     ||
//==================================//

    struct Bebida {
        string nomeBebida;
        string descricaoBebida;
        string fotoBebida;
        string categoriaBebida;
        uint valorBebida;
    }

    struct Prato {
        string nomePrato;
        string descricaoPrato;
        string categoriaPrato;
        string fotoPrato;
        uint valorPrato;
    }   
//==================================\\
// { ESTRUTURA PERFIL DE RECEITAS }  ||
//==================================//
    struct Receita {
        string foto;
        string hashVideoReceita;
        string modoDePreparo;
    }
//==================================\\
//     { ESTRUTURAS DE FOTO }        ||
//==================================//
    struct FotosPerfil {
        string[] fotosAppReceitas;
        string[] fotosAppRestaurantes;
        string[] fotosAppLojas;
    }
//==================================\\
//        { MAPEAMENTOS }            ||
//==================================//
    mapping(address => FotosPerfil) internal mapaFotos;
    mapping(address => Receita) internal receitas;
    mapping(address => Perfil) internal perfis;
    mapping(address => CriarEnd) internal end;

//===================================\\
//          {ARRAYS}                  ||
//===================================//

    string[] comentarios;

//==================================\\
//          { EVENTOS }              ||
//==================================//
    event carregamentoReelscompleto();
    event carregamentoFotoCompleto();
    event editouPerfil();
    event criouEnd();

//==================================\\
//           { FUNÇÕES }              ||
//==================================//

    function EditarPerfil(string memory _nome, string memory _endereco, string memory _genero, string memory _foto, string memory _linkExterno, uint _nascimento) internal {
        perfis[msg.sender] = Perfil(_nome, _endereco, _genero, _foto, _linkExterno, _nascimento);
        emit editouPerfil();
    }

    function EditarEnd(string memory _rua, string memory _bairro, string memory _cidade, string memory _estado, uint _num, uint _cep) internal {
        end[msg.sender] = CriarEnd(_rua, _bairro, _cidade, _estado, _num, _cep);
        emit criouEnd();
    }

    function add5Fotos(string memory _hashFoto) internal {
        require(mapaFotos[msg.sender].fotosAppRestaurantes.length > 0 && mapaFotos[msg.sender].fotosAppRestaurantes.length< 5, "Limite Ultrapassado");
        mapaFotos[msg.sender].fotosAppRestaurantes.push(_hashFoto);
        emit carregamentoFotoCompleto();
    }

//==================================\\
// { ESTRUTURA TIME LINE }           ||
//==================================//

    function criarVideo(string memory _hashVideo) internal {
        hashVideo = _hashVideo;
    }

    function addComentarios(string memory comentario) internal {
        require(bytes(comentario).length <= 300, "Numeros de caracteres excedido");
        comentarios.push(comentario);
    }

    function criarReels(string memory _reels) internal {
        hashVideo = _reels;
        require(block.timestamp >= ultimoPost + 1 days, "Aguarde um dia para postar novamente.");
        ultimoPost = block.timestamp;
        emit carregamentoReelscompleto();
    }

}

