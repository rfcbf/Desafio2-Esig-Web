package br.com.esig.perguntasrespostas.controller;


import br.com.esig.perguntasrespostas.persistence.model.Perguntas;
import br.com.esig.perguntasrespostas.persistence.model.Respostas;
import br.com.esig.perguntasrespostas.persistence.model.Usuario;
import br.com.esig.perguntasrespostas.service.PerguntasService;
import br.com.esig.perguntasrespostas.service.RespostasService;
import br.com.esig.perguntasrespostas.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
public class RestHomeController {

    @Autowired
    private PerguntasService perguntasService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private RespostasService respostasService;

    @GetMapping("/hometemp")
    public String totais(){

        String retorno = "";

        //verificando totais
        List<Usuario> todosUsuarios = usuarioService.recuperar("");
        retorno = "[{\"usuario\" : " + todosUsuarios.size();

        List<Perguntas> todasPerguntas = perguntasService.recuperar("");
        retorno += ", \"perguntas\" : " + todasPerguntas.size();

        List<Respostas> todasRespostas = respostasService.recuperarTodas();
        retorno += ", \"respostas\" : " + todasRespostas.size() + " }]";

        return retorno;

    }

}
