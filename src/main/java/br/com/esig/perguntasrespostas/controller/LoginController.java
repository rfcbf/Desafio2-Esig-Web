package br.com.esig.perguntasrespostas.controller;


import br.com.esig.perguntasrespostas.persistence.model.Global;
import br.com.esig.perguntasrespostas.persistence.model.Usuario;
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
import java.util.List;

@Controller
@RequestMapping("/login")
@SessionAttributes("usuarioLogado")
public class LoginController {

    @Autowired
    private UsuarioService usuarioService;


    @GetMapping("/logar")
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

        return new ModelAndView("/login", model);
    }

    @GetMapping("/editarPerfil")
    public ModelAndView editarContaForm(ModelMap model, HttpSession session){
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

        return new ModelAndView("/editarPerfil", model);
    }

    @GetMapping("/criarConta")
    public ModelAndView criarContaForm(ModelMap model, HttpSession session){
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

        return new ModelAndView("/novoLogin", model);
    }



    @PostMapping("/efetuarLogin")
    public String efetuarLogin(@Valid @ModelAttribute("login") Usuario usuario, BindingResult result, RedirectAttributes attr, HttpSession session) {

        List<Usuario> userList = usuarioService.recuperar(usuario.getEmail());

        if ( !userList.isEmpty() ) {

            if (result.hasErrors()) {
                attr.addFlashAttribute("mensagem", "Preencha todos os campos");
                return "redirect:/login/logar";
            }

            Usuario user = userList.get(0);

            String senha1 = user.getSenha();
            String senha2 = usuario.getSenha();


            if (  !senha1.equals(senha2) ){
                attr.addFlashAttribute("mensagem", "Senha inválida");
                return "redirect:/login/logar";
            }

            session.setAttribute("usuarioLogado", user);

            Global global = Global.getInstance();

            global.setEmail(user.getEmail());
            global.setNomeUser(user.getNome());
            global.setLogado(true);

            return "redirect:/home";
        }else{
            attr.addFlashAttribute("mensagem", "Usuário não encontrado");
            return "redirect:/login/logar";
        }

    }

    @PostMapping("/novaConta")
    public String novaConta(@Valid Usuario usuario, BindingResult result, RedirectAttributes attr, HttpSession session) {

        List<Usuario> userList = usuarioService.recuperar(usuario.getEmail());

        if (result.hasErrors()) {
            attr.addFlashAttribute("mensagem", "Preencha todos os campos");
            return "redirect:/login/criarConta";
        }

        if ( userList.isEmpty() ) {

            usuario.setTipo("U");
            usuarioService.salvar(usuario);

            session.setAttribute("usuarioLogado", usuario);

            Global global = Global.getInstance();

            global.setEmail(usuario.getEmail());
            global.setNomeUser(usuario.getNome());
            global.setLogado(true);

            attr.addFlashAttribute("mensagem", "Conta criada com sucesso!");
            return "redirect:/home";
        }else{
            attr.addFlashAttribute("mensagem", "E-mail já cadastrado");
            return "redirect:/login/criarConta";
        }
    }

    @RequestMapping(value = "/trocarSenha", method = RequestMethod.GET)
    public String trocarSenha(@Valid @ModelAttribute("senhaAtual") String senhaAtual,
                              @Valid @ModelAttribute("senha") String senha,
                              @Valid @ModelAttribute("senha2") String senha2,
                              BindingResult result, RedirectAttributes attr) {

        Global globals = Global.getInstance();

        List<Usuario> userList = usuarioService.recuperar(globals.getEmail());
        Usuario usuario1 = userList.get(0);

        if (result.hasErrors()) {
            attr.addFlashAttribute("mensagem", "Preencha todos os campos");
            return "redirect:/login/editarPerfil";
        }

        if (usuario1.getSenha().equals(senhaAtual)){
            //troca a senha
            usuario1.setSenha(senha);
            usuarioService.atualizar(usuario1);
            attr.addFlashAttribute("mensagem", "Senha atualizada com sucesso!");
            return "redirect:/home";
        }else{
            attr.addFlashAttribute("mensagem", "Senha atual inválida!");
            return "redirect:/login/editarPerfil";

        }

    }


    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes attr) {

        Global global =  Global.getInstance();

        session.removeAttribute("usuarioLogado");
        session.invalidate();

        global.setEmail(null);
        global.setNomeUser(null);
        global.setLogado(false);

        attr.addFlashAttribute("mensagem", "Logout realizado com sucesso!");
        return "redirect:/home";
    }


}
