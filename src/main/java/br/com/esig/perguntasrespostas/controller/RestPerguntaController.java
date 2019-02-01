package br.com.esig.perguntasrespostas.controller;


import br.com.esig.perguntasrespostas.persistence.model.Perguntas;
import br.com.esig.perguntasrespostas.persistence.model.Respostas;
import br.com.esig.perguntasrespostas.persistence.model.Usuario;
import br.com.esig.perguntasrespostas.service.PerguntasService;
import br.com.esig.perguntasrespostas.service.RespostasService;
import br.com.esig.perguntasrespostas.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.Date;
import java.util.List;

@RestController
public class RestPerguntaController {

    @Autowired
    private PerguntasService perguntasService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private RespostasService respostasService;

    @PostMapping("/salvarpergunta/{titulo}/{descricao}/{usuario}")
    public Perguntas novaPergunta(@PathVariable String titulo,
                               @PathVariable String descricao,
                               @PathVariable String usuario
                               ) {


        List<Usuario> userList = usuarioService.recuperar(usuario);
        Usuario usuario1 = userList.get(0);

        Date date = new Date();

        Perguntas perguntas = new Perguntas();

        perguntas.setTitulo(titulo);
        perguntas.setPergunta(descricao);
        perguntas.setUser(usuario1);
        perguntas.setCreatedAt(date);
        perguntasService.salvar(perguntas);

        return perguntas;

    }

    @GetMapping("/getperguntas")
    public List<Perguntas> novaPergunta() {

        List<Perguntas> perguntas = perguntasService.recuperar("");

        for (int i = 0; i < perguntas.size(); i++){
            List<Respostas> countResp = respostasService.recuperar(perguntas.get(i));
            perguntas.get(i).setTotalPergunta(countResp.size());
        }

        return perguntas;
    }


}
