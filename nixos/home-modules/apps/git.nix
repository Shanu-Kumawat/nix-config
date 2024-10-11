{ config, pkgs, ... }:

{
  enable = true;
#  lfs.enable = true;
  userName = "Shanu Kumawat";
  userEmail = "shanukumawat01@gmail.com";
#  signing.key = null;
#  signing.signByDefault = true;

  extraConfig = {
   # pull.rebase = true;
    init.defaultBranch = "main";
    user.signingkey = "52774F4C73D1D434";
    commit.gpgsign = true;
  };
}
