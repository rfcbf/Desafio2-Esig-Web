package br.com.esig.perguntasrespostas.persistence.dao;

import br.com.esig.perguntasrespostas.persistence.model.Usuario;

import java.util.List;

public interface UsuarioDao {

    void salvar(Usuario usuario);

    List<Usuario> recuperar(String filtro);

    Usuario recuperarPorId(Integer id);

    void atualizar(Usuario todo);

    void excluir(Integer id);


}
