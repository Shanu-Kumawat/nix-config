{ ... }:

{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    openFirewall = true;
  };
}
