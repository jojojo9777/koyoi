package com.koyoi.main.service;

import com.koyoi.main.mapper.QuoteMapper;
import com.koyoi.main.vo.QuoteVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.List;

@Service
public class QuoteService {

    @Autowired
    private QuoteMapper quoteMapper;

    public List<QuoteVO> getAllQuotes() {
        return quoteMapper.getAllQuotes();
    }
}
