package br.com.esig.perguntasrespostas.service;


import br.com.esig.perguntasrespostas.persistence.dao.UsuarioDao;
import br.com.esig.perguntasrespostas.persistence.model.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UsuarioServiceImpl implements UsuarioService {

    @Autowired
    private UsuarioDao usuarioDao;

    @Override
    public Usuario salvar(Usuario usuario) {
        usuarioDao.salvar(usuario);
        return usuario;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Usuario> recuperar(String filtro) {
        return usuarioDao.recuperar(filtro);
    }

    @Override
    @Transactional(readOnly = true)
    public Usuario recuperarPorId(Integer id) {
        return usuarioDao.recuperarPorId(id);
    }

    @Override
    public void atualizar(Usuario usuario) {
        usuarioDao.atualizar(usuario);
    }

    @Override
    public void excluir(Integer id) {
        usuarioDao.excluir(id);
    }
}
