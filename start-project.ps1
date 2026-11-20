# ===========================================================
# DSS Railway SIH - Quick Start Script
# ===========================================================
# Usage: Right-click > Run with PowerShell, OR run in terminal
# ===========================================================

$root = $PSScriptRoot

Write-Host ""
Write-Host "🚂 DSS Railway Traffic Management System" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Start Docker services (PostgreSQL + Redis + Backend + Frontend)
Write-Host "▶ Starting all services with Docker Compose..." -ForegroundColor Yellow
Set-Location $root
docker-compose up --build -d

Write-Host ""
Write-Host "⏳ Waiting 30s for services to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

# Step 2: Initialize database (first time only)
Write-Host ""
Write-Host "▶ Setting up database..." -ForegroundColor Yellow
docker-compose exec backend python setup_railway_db.py

Write-Host ""
Write-Host "▶ Creating demo users..." -ForegroundColor Yellow
docker-compose exec backend python setup_auth.py

Write-Host ""
Write-Host "▶ Loading demo data..." -ForegroundColor Yellow
docker-compose exec backend python create_demo_data.py

Write-Host ""
Write-Host "✅ All done! Open these URLs in your browser:" -ForegroundColor Green
Write-Host "   🌐 Frontend:  http://localhost:5173" -ForegroundColor White
Write-Host "   📡 Backend:   http://localhost:8000" -ForegroundColor White
Write-Host "   📚 API Docs:  http://localhost:8000/docs" -ForegroundColor White
Write-Host ""
Write-Host "Demo credentials:" -ForegroundColor Cyan
Write-Host "   CTR001 / railway123   (Supervisor)" -ForegroundColor White
Write-Host "   ADMIN001 / admin123   (Admin)" -ForegroundColor White
Write-Host ""
