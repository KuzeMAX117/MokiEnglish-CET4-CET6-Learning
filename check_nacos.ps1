$url = "http://127.0.0.1:8848/nacos/v1/cs/configs?dataId=service-ai-dev.yaml&group=DEFAULT_GROUP"
try {
    $response = Invoke-RestMethod -Uri $url -Method GET -TimeoutSec 5
    Write-Host "=== Nacos service-ai-dev.yaml ==="
    Write-Host $response
} catch {
    Write-Host "Failed to connect to Nacos: $($_.Exception.Message)"
}
