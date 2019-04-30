package br.com.esig.perguntasrespostas.persistence.dao;

import br.com.esig.perguntasrespostas.persistence.model.Usuario;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class UsuarioDaoImpl implements UsuarioDao {


    @PersistenceContext
    private EntityManager em;


    @Override
    public void salvar(Usuario usuario) {
        em.persist(usuario);
    }

    @Override
    public List<Usuario> recuperar(String filtro) {

        if (filtro.isEmpty()) {
            return em.createQuery(
                    "SELECT c FROM Usuario c ", Usuario.class)
                    .getResultList();
        }else{
            return em.createQuery(
                    "SELECT c FROM Usuario c WHERE c.email = :email", Usuario.class)
                    .setParameter("email", filtro)
                    .getResultList();
        }

    }

    @Override
    public Usuario recuperarPorId(Integer id) {
        return em.find(Usuario.class, id);
    }

    @Override
    public void atualizar(Usuario usuario) {
        em.merge(usuario);
    }

    @Override
    public void excluir(Integer id) {
        em.remove(em.getReference(Usuario.class, id));
    }

}
