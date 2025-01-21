{ config, lib, ... }: rec
{
  withoutArgs = prog: lib.getExe (
    if   config.programs.${prog}.enable 
    then config.programs.${prog}.package
    else
      if config.programs ? prog 
      then throw "Program ${prog} not enabled"
      else
        if config.programs.${prog} ? "package" 
        then throw "Option: programs.${prog}.enable not found."
        else throw "Option: programs.${prog}.package not found."
  );
  withArgs  = prog:       args: (withArgs'   prog {} args);
  withArgs' = prog: opts: args: (withoutArgs prog) + lib.concatStringsSep " " (
    lib.cli.toGNUCommandLine opts args
  );
}
