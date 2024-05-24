{ inputs, config, lib, pkgs, ... }: {
  imports = [ ];
  commands = [
    #{ name = "ldd"; help = "Figure out what libraries a binary needs."; command = "${pkgs.nix-ld}/bin/ldd"; }
  ];
  env = [ ];
  packages = [
    pkgs.bandwidth # Artificial benchmark for identifying weaknesses in the memory subsystem
    pkgs.bench # Command-line benchmark tool
    pkgs.bonnie # Hard drive and file system benchmark suite
    pkgs.cargo-benchcmp # A small utility to compare Rust micro-benchmarks
    pkgs.cargo-criterion # Cargo extension for running Criterion.rs benchmarks
    pkgs.critcmp # A command line tool for comparing benchmarks run by Criterion
    pkgs.dbench # Filesystem benchmark tool based on load patterns
    pkgs.fbmark # Linux Framebuffer Benchmark
    pkgs.filebench # File system and storage benchmark that can generate both micro and macro workloads
    pkgs.fio # Flexible IO Tester - an IO benchmark tool
    pkgs.fsmark # Synchronous write workload file system benchmark
    pkgs.geekbench # Cross-platform benchmark
    pkgs.glmark2 # OpenGL (ES) 2.0 benchmark
    pkgs.hp2p # A MPI based benchmark for network diagnostics
    pkgs.hyperfine # Command-line benchmarking tool
    pkgs.iozone # IOzone Filesystem Benchmark
    pkgs.lzbench # In-memory benchmark of open-source LZ77/LZSS/LZMA compressors
    pkgs.nbench # A synthetic computing benchmark program
    pkgs.netperf # Benchmark to measure the performance of many different types of networking
    pkgs.ntttcp # A Linux network throughput multiple-thread benchmark tool
    pkgs.rewrk # A more modern http framework benchmarker supporting HTTP/1 and HTTP/2 benchmarks
    pkgs.sockperf # Network Benchmarking Utility
    pkgs.stress-ng # Stress test a computer system
    pkgs.sysbench # Modular, cross-platform and multi-threaded benchmark tool
    pkgs.tsung # A high-performance benchmark framework for various protocols including HTTP, XMPP, LDAP, etc
    pkgs.ttfb # CLI-Tool to measure the TTFB (time to first byte) of HTTP(S) requests
  ];
}
