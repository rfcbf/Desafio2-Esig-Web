package br.com.esig.perguntasrespostas.persistence.dao;

import br.com.esig.perguntasrespostas.persistence.model.Perguntas;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class PerguntasDaoImpl implements PerguntasDao {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void salvar(Perguntas perguntas) {
        em.persist(perguntas);
    }

    @Override
    public List<Perguntas> recuperar(String filtro) {
        if (filtro.isEmpty()) {
            return em.createQuery(
                    "SELECT c FROM Perguntas c ", Perguntas.class)
                    .getResultList();
        }else{
            return em.createQuery(
                    "SELECT c FROM Perguntas c WHERE c.titulo like :titulo", Perguntas.class)
                    .setParameter("titulo", filtro)
                    .getResultList();
        }

    }

    @Override
    public Perguntas recuperarPorId(Long id) {
        return em.find(Perguntas.class, id);
    }

    @Override
    public void atualizar(Perguntas perguntas) {
        em.merge(perguntas);
    }

    @Override
    public void excluir(Long id) {
        em.remove(em.getReference(Perguntas.class, id));
    }
}
