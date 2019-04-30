package br.com.esig.perguntasrespostas.controller;


import br.com.esig.perguntasrespostas.persistence.model.Global;
import br.com.esig.perguntasrespostas.persistence.model.Perguntas;
import br.com.esig.perguntasrespostas.persistence.model.Usuario;
import br.com.esig.perguntasrespostas.service.PerguntasService;
import br.com.esig.perguntasrespostas.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/perguntas")
public class PerguntaController {

    @Autowired
    private PerguntasService perguntasService;

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/criar")
    public ModelAndView loginForm(ModelMap model, HttpSession session) {

        Global globals = Global.getInstance();

        //Object user = session.getAttribute("usuarioLogado");

        if (globals.isLogado()){
            model.addAttribute("sessionEmail",  globals.getEmail() );
            model.addAttribute("sessionNome", globals.getNomeUser());
            model.addAttribute("sessionLogado", true);
        }else{
            model.addAttribute("sessionEmail", null);
            model.addAttribute("sessionNome", null);
            model.addAttribute("sessionLogado", false);
        }

        return new ModelAndView("/novaPergunta", model);
    }

    @PostMapping("/salvar")
    public String novaPergunta(@Valid Perguntas perguntas, BindingResult result, RedirectAttributes attr) {

        Global globals = Global.getInstance();

        List<Usuario> userList = usuarioService.recuperar(globals.getEmail());
        Usuario usuario1 = userList.get(0);

        if (result.hasErrors()) {
            attr.addFlashAttribute("mensagem", "Preencha todos os campos");
            return "redirect:/perguntas/criar";
        }

        //DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
        Date date = new Date();

        perguntas.setUser(usuario1);
        perguntas.setCreatedAt(date);
        perguntasService.salvar(perguntas);

        attr.addFlashAttribute("mensagem", "Pergunta criada com sucesso!");
        return "redirect:/home";

    }

    @GetMapping("{id}/atualizar")
    public ModelAndView preAtualizar(@PathVariable("id") Long id, ModelMap model) {

        Global globals = Global.getInstance();

//        Object user = session.getAttribute("usuarioLogado");

        if (globals.isLogado()){
            model.addAttribute("sessionEmail",  globals.getEmail() );
            model.addAttribute("sessionNome", globals.getNomeUser());
            model.addAttribute("sessionLogado", true);
        }else{
            model.addAttribute("sessionEmail", null);
            model.addAttribute("sessionNome", null);
            model.addAttribute("sessionLogado", false);
        }

        Perguntas perguntas = perguntasService.recuperarPorId(id);
        model.addAttribute("perguntaAtualizar", perguntas);
        return new ModelAndView("/novaPergunta", model);

    }

    @PostMapping("/salvarAtualizacao")
    public String atualizarConta(@Valid Perguntas perguntas, BindingResult result, RedirectAttributes attr) {

        if (result.hasErrors()) {
            attr.addFlashAttribute("mensagem", "Preencha todos os campos");
            return "redirect:/perguntas/criar";
        }

        Perguntas perguntas1 = perguntasService.recuperarPorId(perguntas.getId());
        perguntas.setUser(perguntas1.getUser());
        perguntas.setCreatedAt(perguntas1.getCreatedAt());
        perguntasService.atualizar(perguntas);

        attr.addFlashAttribute("mensagem", "Pergunta atualizada com sucesso!");
        return "redirect:/home";

    }


    @GetMapping("{id}/excluir")
    public String remover(@PathVariable("id") Long id, RedirectAttributes attr) {
        perguntasService.excluir(id);
        attr.addFlashAttribute("mensagem", "Pergunta excluida com sucesso!");
        return "redirect:/home";
    }


}
