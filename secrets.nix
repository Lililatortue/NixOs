let
    lililatortue = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDn+GzL/9/FpGStu3mpzLk11uTtaL+QfFEDmFkPT1EKL will.descoteaux@gmail.com";
in {
    
    "secrets/git.age".publicKeys         = [ lililatortue ]; # git
    "secrets/api-gemini.age".publicKeys  = [ lililatortue ]; # gemini
    "secrets/ssh-macmini.age".publicKeys = [ lililatortue ]; # server
    "secrets/ssh-minipcs.age".publicKeys = [ lililatortue ]; # webserver
}
