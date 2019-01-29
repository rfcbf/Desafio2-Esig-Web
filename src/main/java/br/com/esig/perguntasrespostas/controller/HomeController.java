package br.com.esig.perguntasrespostas.controller;


import br.com.esig.perguntasrespostas.persistence.model.Global;
import br.com.esig.perguntasrespostas.persistence.model.Perguntas;
import br.com.esig.perguntasrespostas.persistence.model.Respostas;
import br.com.esig.perguntasrespostas.persistence.model.Usuario;
import br.com.esig.perguntasrespostas.service.PerguntasService;
import br.com.esig.perguntasrespostas.service.RespostasService;
import br.com.esig.perguntasrespostas.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@SessionAttributes("usuarioLogado")
public class HomeController {

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private PerguntasService perguntasService;

    @Autowired
    private RespostasService respostasService;

    @RequestMapping({"/home","/"})
    public ModelAndView home(ModelMap model, HttpSession session) {

        Global globals = Global.getInstance();

        Object user = session.getAttribute("usuarioLogado");

        //verificando totais
        List<Usuario> todosUsuarios = usuarioService.recuperar("");
        model.addAttribute("totalUsuario",  todosUsuarios.size() );

        List<Perguntas> todasPerguntas = perguntasService.recuperar("");
        model.addAttribute("totalPerguntas",  todasPerguntas.size() );

        List<Respostas> todasRespostas = respostasService.recuperarTodas();
        model.addAttribute("totalResposta",  todasRespostas.size() );


        for (int i = 0; i < todasPerguntas.size(); i++){
            List<Respostas> countResp = respostasService.recuperar(todasPerguntas.get(i));
            todasPerguntas.get(i).setTotalPergunta(countResp.size());
        }

        model.addAttribute("perguntas", todasPerguntas);

        if (globals.isLogado()){
            model.addAttribute("sessionEmail",  globals.getEmail() );
            model.addAttribute("sessionNome", globals.getNomeUser());
            model.addAttribute("sessionLogado", true);
        }else{
            model.addAttribute("sessionEmail", null);
            model.addAttribute("sessionNome", null);
            model.addAttribute("sessionLogado", false);
        }

        return new ModelAndView("/home", model);
    }



}
