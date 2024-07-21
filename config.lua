Config = {}

Config.Cooldown = { -- Time is in seconds !
     ["firework"] = (60 * 3),
}

Config.FireWorkParticleList = {
     FIRE = {
          dic = "scr_rcpaparazzo1",
          fx  = "scr_mich4_firework_trailburst"
     },
     START = {
          dic = "scr_indep_fireworks",
          fx  = "scr_indep_firework_fountain"
     },
     Effects = {
          [1] = {
               dic = "scr_rcpaparazzo1",
               fx  = "scr_mich4_firework_burst_spawn"
          },
          [2] = {
               dic = "scr_indep_fireworks",
               fx  = "scr_indep_firework_trailburst_spawn"
          },
          [3] = {
               dic = "scr_indep_fireworks",
               fx  = "scr_indep_firework_burst_spawn"
          },
          [4] = {
               dic = "proj_xmas_firework",
               fx  = "scr_firework_xmas_ring_burst_rgw"
          },
          [5] = {
               dic = "proj_xmas_firework",
               fx  = "scr_firework_xmas_ring_burst_rgw"
          },
          [6] = {
               dic = "proj_xmas_firework",
               fx  = "scr_firework_xmas_ring_burst_rgw"
          },
          [7] = {
               dic = "proj_indep_firework",
               fx  = "scr_indep_firework_air_burst"
          },
          [8] = {
               dic = "proj_indep_firework",
               fx  = "scr_indep_firework_air_burst"
          },
          [9] = {
               dic = "proj_indep_firework_v2",
               fx  = "scr_firework_indep_spiral_burst_rwb"
          },
          [10] = {
               dic = "proj_indep_firework_v2",
               fx  = "scr_firework_indep_ring_burst_rwb"
          },
     },

}

Config.Lan = {
     ["onCooldown"] = "You need to wait"
}
