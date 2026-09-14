package com.hao.topic.topic.service;

import com.hao.topic.model.vo.topic.PkRankVo;

import java.util.List;
import java.util.Map;

public interface PkService {

    
    void startMatch(Long userId);

    
    void cancelMatch(Long userId);

    
    Map<String, Object> submitAnswer(Long userId, String roomId, int questionIndex, String answer);

    
    void endRoom(String roomId);

    
    List<PkRankVo> getRank(String type, int page, int size);

    
    Map<String, Object> getMyPkStats(Long userId);

    
    Map<String, Object> submitWarmUp(Long userId, String roomId, int questionIndex, String answer);

    
    int getUserLevel(Long userId);

    
    void startBattle(String roomId, Long userIdA, Long userIdB);

    
    void startNextRound(String roomId, int round, Long userId);
}
