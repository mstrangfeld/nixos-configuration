{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      directory = {
        truncation_length = 8;
        truncate_to_repo = false;
      };
      git_branch = {
        style = "bold green";
      };
    };
  };
}
