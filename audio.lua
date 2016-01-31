audio={}
time = 10
switchMusic = true

function audio.load()
  audio.menuMusic = love.audio.newSource("/Assets/OST/Título.mp3")
  audio.stage1Music = love.audio.newSource("/Assets/OST/Distrito Pacífico.mp3")
  audio.bossMusic = love.audio.newSource("/Assets/OST/Distrito Destruído.mp3")
  audio.gameoverMusic = love.audio.newSource("/Assets/SFX/Game Over.mp3")
  audio.musicPlaying = nil
  timer = 0
  audio.pJumpSound = love.audio.newSource("/Assets/SFX/Game Over.mp3")
  audio.pJumpSound:setVolume(0.3)
  audio.pPunchSound = love.audio.newSource("/Assets/SFX/Game Over.mp3")
  audio.pPunchSound:setVolume(0.3)
  audio.pDeathSound = love.audio.newSource("/Assets/SFX/Game Over.mp3")
  audio.pDeathSound:setVolume(1)
  audio.menuStartSound = love.audio.newSource("/Assets/SFX/Game Over.mp3")
  audio.menuStartSound:setVolume(0.5)
  audio.powerupSound = love.audio.newSource("/Assets/SFX/Game Over.mp3")
  audio.powerupSound:setVolume(0.5)
  --etc
end

function audio.play(music)
  if audio.musicPlaying ~= nil then
    love.audio.stop(audio.musicPlaying)
  end
  audio.musicPlaying = music
	music:setLooping(true)
  music:setVolume(0.3)
	love.audio.play(music)
end

function audio.playPlayerJump()
  love.audio.stop(audio.pRunSound)
  audio.playSfx(audio.pJumpSound)
end
function audio.playPlayerRun()
  love.audio.stop(audio.pJumpSound)
  return
end
function audio.playPlayerAttack()
  audio.playSfx(audio.pAttSound)
end
function audio.playBullet()
  audio.playSfx(audio.bulletSound)
  audio.playFire()
end
function audio.playMenuStart()
  audio.playSfx(audio.menuStartSound)
end
function audio.playDragonDeath()
  audio.playSfx(audio.dragonDeathSound)
end
function audio.playPowerup()
  audio.playSfx(audio.powerupSound)
end
function audio.playFire()
  audio.playSfx(audio.fireloopSound)
end
function audio.stopFire()
  love.audio.stop(audio.fireloopSound)
end
function audio.playShield()
  audio.playSfx(audio.shieldSound)
end
function audio.enterGameover()
  audio.play(audio.gameoverMusic)
end
function audio.playBossMusic()
  audio.play(audio.bossMusic)
end
function audio.leaveGameover()
  audio.play(audio.stageMusic)
end
function audio.playDgScream()
  audio.playSfx(audio.dragonScream)
end

function audio.playSfx(sfx)
  if sfx:isPlaying() then
    love.audio.stop(sfx)
  end
  love.audio.play(sfx)
end

function audio.update(dt)
  --audio.switchTest(dt)
end

function audio.switchTest(dt)
  if switchMusic then
  timer = timer + dt
  if timer >= time then
    switchMusic = false
    audio.play(audio.bossMusic)
  end
  end
end