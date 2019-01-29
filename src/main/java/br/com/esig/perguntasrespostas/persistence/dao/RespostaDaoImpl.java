package br.com.esig.perguntasrespostas.persistence.dao;

import br.com.esig.perguntasrespostas.persistence.model.Perguntas;
import br.com.esig.perguntasrespostas.persistence.model.Respostas;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class RespostaDaoImpl implements RespostaDao {

    @PersistenceContext
    private EntityManager em;

    @Override
    public void salvar(Respostas respostas) {
        em.persist(respostas);
    }

    @Override
    public List<Respostas> recuperar(Perguntas filtro) {
        if (filtro.getId().toString().isEmpty()) {
            return em.createQuery(
                    "SELECT c FROM Respostas c order by c.createdAt", Respostas.class)
                    .getResultList();
        }else{
            return em.createQuery(
                    "SELECT c FROM Respostas c WHERE c.pergunta = :pergunta order by c.createdAt", Respostas.class)
                    .setParameter("pergunta", filtro)
                    .getResultList();
        }
    }

    @Override
    public List<Respostas> recuperarTodas() {
        return em.createQuery(
                "SELECT c FROM Respostas c order by c.createdAt", Respostas.class)
                .getResultList();
    }


    @Override
    public Respostas recuperarPorId(Long id) {
        return em.find(Respostas.class, id);
    }

    @Override
    public void atualizar(Respostas respostas) {
        em.merge(respostas);
    }

    @Override
    public void excluir(Long id) {
        em.remove(em.getReference(Respostas.class, id));
    }
}
