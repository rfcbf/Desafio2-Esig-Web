package br.com.esig.perguntasrespostas.service;

import br.com.esig.perguntasrespostas.persistence.dao.RespostaDao;
import br.com.esig.perguntasrespostas.persistence.model.Perguntas;
import br.com.esig.perguntasrespostas.persistence.model.Respostas;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class RespostasServiceImpl implements RespostasService{

    @Autowired
    private RespostaDao respostaDao;

    @Override
    public Respostas salvar(Respostas respostas) {
        respostaDao.salvar(respostas);
        return respostas;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Respostas> recuperar(Perguntas filtro) {
        return respostaDao.recuperar(filtro);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Respostas> recuperarTodas() {
        return respostaDao.recuperarTodas();
    }


    @Override
    @Transactional(readOnly = true)
    public Respostas recuperarPorId(Long id) {
        return respostaDao.recuperarPorId(id);
    }

    @Override
    public void atualizar(Respostas respostas) {
        respostaDao.atualizar(respostas);
    }

    @Override
    public void excluir(Long id) {
        respostaDao.excluir(id);
    }

}
