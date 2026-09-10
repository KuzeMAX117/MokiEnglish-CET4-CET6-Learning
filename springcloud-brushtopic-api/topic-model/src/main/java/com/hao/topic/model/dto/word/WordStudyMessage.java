package com.hao.topic.model.dto.word;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WordStudyMessage {
    private Long userId;
    private String studyDate;
    private String nickname;
    private String avatar;
    private String role;
}
