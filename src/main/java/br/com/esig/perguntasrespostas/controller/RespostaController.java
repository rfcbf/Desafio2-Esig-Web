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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/resposta")
public class RespostaController {

    @Autowired
    private PerguntasService perguntasService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private RespostasService respostasService;

    @GetMapping("{id}/lista")
    public ModelAndView loginForm(@PathVariable("id") Long id, ModelMap model, HttpSession session) {

        Global globals = Global.getInstance();

        Object user = session.getAttribute("usuarioLogado");

        Perguntas pergunta = perguntasService.recuperarPorId(id);
        List<Respostas> resposta = respostasService.recuperar(pergunta);

        model.addAttribute("pergunta", pergunta);
        model.addAttribute("respostas", resposta);

        if (globals.isLogado()){
            model.addAttribute("sessionEmail",  globals.getEmail() );
            model.addAttribute("sessionNome", globals.getNomeUser());
            model.addAttribute("sessionLogado", true);
        }else{
            model.addAttribute("sessionEmail", null);
            model.addAttribute("sessionNome", null);
            model.addAttribute("sessionLogado", false);
        }

        return new ModelAndView("/resposta", model);
    }

    @PostMapping("/salvar")
    public String novaResposta(@Valid Respostas respostas, BindingResult result, RedirectAttributes attr) {

        Global globals = Global.getInstance();

        List<Usuario> userList = usuarioService.recuperar(globals.getEmail());
        Usuario usuario1 = userList.get(0);
        respostas.setUser(usuario1);

        DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
        Date date = new Date();
        respostas.setCreatedAt(date);

        Perguntas perguntas = perguntasService.recuperarPorId(respostas.getPerguntaID());
        respostas.setPergunta(perguntas);

        respostasService.salvar(respostas);

        attr.addFlashAttribute("mensagem", "Resposta enviada com sucesso!");
        return "redirect:/resposta/" + respostas.getPerguntaID() + "/lista";

    }

    @GetMapping("{idPergunta}/{idResposta}/excluir")
    public String remover(@PathVariable("idPergunta") Long idPergunta,
                          @PathVariable("idResposta") Long idResposta,
                          RedirectAttributes attr) {

        respostasService.excluir(idResposta);
        attr.addFlashAttribute("mensagem", "Resposta excluida com sucesso!");
        return "redirect:/resposta/" + idPergunta + "/lista";
    }



}
