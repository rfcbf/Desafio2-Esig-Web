package br.com.esig.perguntasrespostas.controller;

import br.com.esig.perguntasrespostas.persistence.model.Usuario;
import br.com.esig.perguntasrespostas.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
public class RestLoginController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/efetuarLogin/{email}/{senha}")
    public Usuario efetuarLogin(@PathVariable String email,
                               @PathVariable String senha) {

        List<Usuario> userList = usuarioService.recuperar(email);

        if (userList.size()>0){
            Usuario user = userList.get(0);
            String senha1 = user.getSenha();

            if (  !senha1.equals(senha) ){
                return null;
            }

            return user;

        }else{
            return null;
        }

    }

    @PostMapping("/novaConta/{nome}/{email}/{senha}")
    public Usuario novaConta(@PathVariable String nome,
                             @PathVariable String email,
                             @PathVariable String senha) {

        List<Usuario> userList = usuarioService.recuperar(email);

        if ( userList.isEmpty() ) {

            Usuario user = new Usuario();
            user.setNome(nome);
            user.setEmail(email);
            user.setSenha(senha);
            user.setTipo("U");

            usuarioService.salvar(user);

            return user;
        }else{
            return null;
        }
    }

}
