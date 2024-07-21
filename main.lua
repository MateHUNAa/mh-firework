mCore = exports["mCore"]:getSharedObj()
local Props, CoolDown = {}, {}

exports("firework", (function(data, slot)
     local myped = PlayerPedId()

     if CoolDown[data.name] then
          local cd = Config.Cooldown[data.name]
          if mCore.isDebug() then cd = 15 end
          local coolDownElapsedTime = (GetGameTimer() - CoolDown[data.name]) / 1000
          local remainingCooldown = cd - coolDownElapsedTime
          if coolDownElapsedTime < cd then
               local minutes = math.floor(remainingCooldown / 60)
               local seconds = math.floor(remainingCooldown % 60)

               local message = string.format(
                    mCore.isDebug() and "[Dev]: ReducedTime: %02d:%02d" or Config.Lan["onCooldown"] .. " %02d:%02d",
                    minutes, seconds
               )
               mCore.Notify("Outfive Roleplay", message, "info", 3500)
               return
          end
     end

     if mCore.HasItem(data.name, 1) then
          CoolDown[data.name] = GetGameTimer()

          local fireWork = mCore.makeProp({
               prop = "ind_prop_firework_01",
               coords = vec4(0.0, 0.0, 0.0, 0.0)
          })

          AttachEntityToEntity(fireWork, myped, GetPedBoneIndex(myped, 60309), 0.2, 0.05, 0.0, 180.0, 90.0, 90.0, true,
               true,
               false, true, 1, true)
          local pedHeading = GetEntityHeading(myped)

          if mCore.progressBar({
                   time   = mCore.isDebug() and 1500 or data.client.usetime,
                   label  = "Using " .. data.label,
                   dead   = true,
                   cancel = true,
                   dict   = "amb@prop_human_bum_bin@idle_a",
                   anim   = "idle_a",
              }) then
               DeleteEntity(fireWork)
               mCore.toggleItem(false, data.item, 1)
               local startTime = GetGameTimer()
               local startCoord = GetEntityCoords(myped)

               Props[#Props + 1] = mCore.makeProp({
                    prop   = "ind_prop_firework_01",
                    coords = vec4(startCoord.x, startCoord.y + .25, startCoord.z, 0.0),
               }, true --[[freezed]], true --[[synced]])

               local charging = true
               Citizen.CreateThread((function()
                    while charging do
                         mCore.PlayNetFx({
                              coord   = targetCoords,
                              dic     = Config.FireWorkParticleList.START.dic,
                              fx      = Config.FireWorkParticleList.START.fx,
                              scale   = 1.25,
                              timeout = 255,
                              color   = vec3(1.0, 1.0, 1.0),
                              offset  = vec3(-.06, 0.0, 1.45),
                              rot     = vec3(180.0, 0.0, 0.0),
                              entity  = Props[#Props]
                         })
                         Wait(255)
                    end
               end))
               Wait(data.client.triggerTime)
               charging = false
               FreezeEntityPosition(Props[#Props], false)

               local forceX = math.sin(math.rad(-pedHeading)) * 50.0
               local forceY = math.cos(math.rad(-pedHeading)) * 50.0
               local forceZ = 100.0

               ApplyForceToEntity(Props[#Props], 1, forceX, forceY, forceZ, 0.0, 0.0, 0.0, 0, false, true, false,
                    false,
                    true)


               Wait(500)
               local particle = true
               Citizen.CreateThread((function()
                    while particle do
                         local randomEff = Config.FireWorkParticleList.Effects
                             [math.random(1, #Config.FireWorkParticleList.Effects)]

                         TriggerServerEvent("mCore:server:net:addFxToEntity", {
                              coord   = targetCoords,
                              dic     = tostring(randomEff.dic),
                              fx      = tostring(randomEff.fx),
                              scale   = 2.0,
                              timeout = 500,
                              color   = vec3(1.0, 1.0, 1.0),
                              offset  = vec3(0.0, 0.0, 0.0),
                              entity  = Props[#Props]
                         })
                         Wait(550)
                    end
               end))
               Wait(data.client.effectTime)
               particle = false

               -- CleanUp
               mCore.destoryProp(Props[#Props])
               mCore.unloadModel("ind_prop_firework_01")
               mCore.RemoveExistingParticleEffect()
          end
     end
end))


AddEventHandler("onResourceStop", (function(r)
     if GetCurrentResourceName() ~= r then return end
     CleanUp()
end))
