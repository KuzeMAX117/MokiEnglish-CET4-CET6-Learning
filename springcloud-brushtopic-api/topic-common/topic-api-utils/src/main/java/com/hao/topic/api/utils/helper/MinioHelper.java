package com.hao.topic.api.utils.helper;

import com.alibaba.fastjson2.util.DateUtils;
import com.hao.topic.api.utils.minio.MinioConfig;
import com.hao.topic.api.utils.properties.MinIOConfigProperties;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import io.minio.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.FilterInputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.Date;
import java.util.UUID;

@Component
@Slf4j
public class MinioHelper {

    @Autowired
    private MinIOConfigProperties minIOConfigProperties;

    @Autowired
    private MinioConfig minioConfig;

    

    public String uploadFile(MultipartFile file, String path) {
        try {
            
            MinioClient minioClient = minioConfig.buildMinioClient();
            
            boolean isBucket = minioClient.bucketExists(
                    BucketExistsArgs.builder()
                            .bucket(minIOConfigProperties.getBucket())
                            .build()
            );
            
            if (!isBucket) {
                
                minioClient.makeBucket(MakeBucketArgs.builder()
                        .bucket(minIOConfigProperties.getBucket())
                        .build());
            } else {
                log.info("桶存在");
            }

            
            
            String date = DateUtils.format(new Date(), "yyyyMMdd");
            
            String uuid = UUID.randomUUID().toString().replace("-", "");

            
            String fileName = path + "/" + date + "/" + uuid;
            try (InputStream inputStream = file.getInputStream()) {
                
                PutObjectArgs build = PutObjectArgs.builder()
                        .bucket(minIOConfigProperties.getBucket())
                        .object(fileName)
                        .stream(inputStream, file.getSize(), -1)
                        .build();
                
                minioClient.putObject(build);
                
                return minIOConfigProperties.getReadPath() + "/" + minIOConfigProperties.getBucket() + "/" + fileName;
            }
        } catch (Exception e) {
            throw new TopicException(ResultCodeEnum.UPLOAD_FILE_ERROR);
        }
    }

    

    public void delUpload(String path) {
        try {
            MinioClient minioClient = minioConfig.buildMinioClient();
            
            minioClient.removeObject(RemoveObjectArgs.builder().bucket(minIOConfigProperties.getBucket()).object(path).build());
            log.info("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            log.info("删除失败");
        }
    }
}
