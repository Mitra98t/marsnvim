use colored::Colorize;
use inquire::Confirm;
use inquire::Select;
use std::fs::File;
use std::io::Write;
use std::process::Command;
use std::{env, fs, process::exit, str};

#[derive(Debug)]
/// Line number style configs
///
/// * `num_type`: line number style
struct LineNumStyle {
    num_type: String,
}

#[derive(Debug, Clone)]
/// Colorscheme struct
///
/// * `name`: colorscheme logical name
/// * `id`: id to use when setting up the colorscheme
/// * `install_link`: link from which to install the colorscheme
struct Colorscheme {
    name: String,
    id: String,
    install_link: String,
}

#[derive(Debug)]
/// Custom setting collection
///
/// * `line_num_style`: syle of line number
/// * `colorscheme`: chosen colorscheme
struct CustomSettings {
    line_num_style: LineNumStyle,
    colorscheme: Colorscheme,
}

impl CustomSettings {
    fn new() -> Self {
        Self {
            line_num_style: LineNumStyle {
                num_type: "relative".to_owned(),
            },
            colorscheme: Colorscheme {
                name: "tokyonight".to_owned(),
                id: "tokyonight-storm".to_owned(),
                install_link: "folke/tokyonight.nvim".to_owned(),
            },
        }
    }

    /// returns the lua snippet setting up line numbers
    fn line_number(&self) -> String {
        match &self.line_num_style.num_type[..] {
            "relative" => "opt.relativenumber = true\n".to_owned(),
            "static" => "opt.relativenumber = false\n".to_owned(),
            _ => "opt.relativenumber = true\n".to_owned(),
        }
    }

    /// return the lua snippet setting up the colorscheme
    fn colorscheme(&self) -> String {
        match &self.colorscheme.name[..] {
            "tokyonight" => format!("return {{\n{{'{}',\nlazy = false,\npriority = 999,\nconfig = function()\nvim.cmd([[colorscheme {}]])\nend,}}\n}}",
                self.colorscheme.install_link,
                self.colorscheme.id),
            "everforest" => format!("return {{\n{{'{}',\nlazy = false,\npriority = 999,\nconfig = function()\nvim.cmd([[colorscheme {}]])\nend,}}\n}}",
                self.colorscheme.install_link,
                self.colorscheme.id),
            "gruvbox" => format!("return {{\n{{'{}',\nlazy = false,\npriority = 999,\nconfig = function()\nvim.cmd([[colorscheme {}]])\nend,}}\n}}",
                self.colorscheme.install_link,
                self.colorscheme.id),
            _ => format!("return {{\n{{'{}',\nlazy = false,\npriority = 999,\nconfig = function()\nvim.cmd([[colorscheme {}]])\nend,}}\n}}",
                self.colorscheme.install_link,
                self.colorscheme.id),
        }
    }
}

#[derive(Debug)]
/// Struct of all the requirements needed for the installation
///
/// * `req_list`: list of the executables names
/// * `req_res`: parallel list, true if the executable was found false if it was missing
struct Requirements {
    req_list: Vec<String>,
    req_res: Vec<bool>,
}

impl Requirements {
    fn new(req_list_in: Vec<&str>) -> Self {
        let req_list_string: Vec<String> = req_list_in.into_iter().map(|x| x.to_string()).collect();
        Requirements {
            req_list: req_list_string.clone(),
            req_res: vec![false; req_list_string.len()],
        }
    }

    /// Set the status of an executable
    ///
    /// * `exe`: executable name
    /// * `status`: executable status true if found false if missing
    fn set_req(&mut self, exe: &str, status: bool) {
        for (idx, req) in self.req_list.iter().enumerate() {
            if req == exe {
                self.req_res[idx] = status;
            }
        }
    }

    /// Find the program in the host path
    ///
    /// * `program`: executable name to find
    fn is_program_in_path(&mut self, program: &str) {
        if let Ok(path) = env::var("PATH") {
            for p in path.split(":") {
                let p_str = format!("{}/{}", p, program);
                if fs::metadata(p_str).is_ok() {
                    self.set_req(program, true);
                    return;
                }
            }
        }
        self.set_req(program, false);
    }

    /// Check if all the executable listed in `self.req_list` are installed in the machine
    fn check_all_installed(&mut self) {
        for req in self.req_list.clone() {
            self.is_program_in_path(&req);
        }
    }

    /// Print the result of the executables check to the user
    fn print_result(&self) {
        for (idx, req) in self.req_list.iter().enumerate() {
            if self.req_res[idx] {
                println!("{} = {} found!", "OK".green(), req.cyan());
            } else {
                println!("{} = {} missing!", "ERR".red(), req.cyan());
            }
        }
    }

    /// returns true if all the requirements were met false otherwise
    fn is_all_ok(&self) -> bool {
        for res in self.req_res.clone() {
            if !res {
                return res;
            }
        }
        return true;
    }
}

/// clears screen and set cursor at top left
fn clear_screen() {
    print!("{esc}[2J{esc}[1;1H", esc = 27 as char);
}

/// Given a string this function ensures that the length is the given one
/// The function appends spaces
///
/// * `input`: string to modify
/// * `len`: length of the string to met
fn format_string_complete_chars(input: &str, len: i32) -> String {
    if len < input.len() as i32 {
        return input.to_owned();
    }
    let missing: i32 = len - input.len() as i32;
    let mut res = input.to_owned();
    for _ in 0..missing {
        res.push_str(" ");
    }
    return res;
}

/// Prints the formatted table with the line numbering system example
fn print_line_number_style_example() {
    println!("Static\tRelative");
    let static_num = vec!["┊ ...", "┊ 21", "┊ 22", "┊ 23", "┊ 24", "┊ 25", "┊ ..."];
    let relati_num = vec!["┊ ...", "┊ 2", "┊ 1", "┊ 23", "┊ 1", "┊ 2", "┊ ..."];
    for i in 0..static_num.len() {
        if i == 3 {
            println!(
                "{}\t{}",
                format_string_complete_chars(static_num[i], 9)
                    .on_truecolor(50, 50, 50)
                    .cyan(),
                format_string_complete_chars(relati_num[i], 9)
                    .on_truecolor(50, 50, 50)
                    .cyan(),
            );
        } else {
            println!(
                "{}\t{}",
                format_string_complete_chars(static_num[i], 9)
                    .on_truecolor(30, 30, 30)
                    .blue(),
                format_string_complete_chars(relati_num[i], 9)
                    .on_truecolor(30, 30, 30)
                    .blue(),
            );
        }
    }
}

fn main() {
    clear_screen();

    let mut settings: CustomSettings = CustomSettings::new();

    let req_list: Vec<&str> = vec!["nvim", "fzf", "git", "lazygit", "fd", "rg"];
    let mut requirements: Requirements = Requirements::new(req_list);

    requirements.check_all_installed();

    requirements.print_result();

    if requirements.is_all_ok() {
        println!("\nAll the requirements are met!");
    } else {
        println!("\nInstall the missing requirements with your favourite package manager!");
        exit(64);
    }

    let start_installation_ans = Confirm::new("Procede with installation?")
        .with_default(true)
        .prompt();

    match start_installation_ans {
        Ok(true) => {
            clear_screen();
        }
        Ok(false) => {
            println!("Exiting...");
            exit(65);
        }
        Err(_) => panic!("Some error occurred!"),
    }

    // FIX: Make backup work
    //
    // let home = env::var("HOME").expect("Failed retriving HOME path");
    // let mut nvim = home.clone();
    // nvim.push_str("/.config/nvim}");
    // let mut nvim_bak = home.clone();
    // nvim_bak.push_str("/.config/nvim.bak}");
    //
    // Command::new("mv")
    //     .args(&[nvim, nvim_bak])
    //     .output()
    //     .expect("Some error backing up nvim");
    //
    // println!("{} = old nvim configuration backed up!", "OK".green());
    //
    // println!("\n-----------------------\n");
    //
    // let bak_stuff_ans = Confirm::new("Backup plugins and other installed stuff by nvim?")
    //     .with_default(false)
    //     .prompt();
    //
    // match bak_stuff_ans {
    //     Ok(true) => {
    //         let mut share = home.clone();
    //         share.push_str("/.local/share/nvim");
    //         let mut share_bak = home.clone();
    //         share_bak.push_str("/.local/share/nvim.bak");
    //         let mut state = home.clone();
    //         state.push_str("/.local/state/nvim");
    //         let mut state_bak = home.clone();
    //         state_bak.push_str("/.local/state/nvim.bak");
    //         let mut cache = home.clone();
    //         cache.push_str("/.cache/nvim");
    //         let mut cache_bak = home.clone();
    //         cache_bak.push_str("/.cache/nvim.bak");
    //         Command::new("mv")
    //             .args(&[share, share_bak])
    //             .output()
    //             .expect("Some error backing up nvim");
    //         Command::new("mv")
    //             .args(&[state, state_bak])
    //             .output()
    //             .expect("Some error backing up nvim");
    //         Command::new("mv")
    //             .args(&[cache, cache_bak])
    //             .output()
    //             .expect("Some error backing up nvim");
    //     }
    //     Ok(false) => {}
    //     Err(_) => panic!("Some error occurred!"),
    // }

    println!("\n-----------------------\n");

    print_line_number_style_example();
    let line_number_options: Vec<&str> = vec!["Static", "Relative"];
    let line_number_selection_ans: Result<&str, inquire::InquireError> =
        Select::new("Select line number style", line_number_options).prompt();
    match line_number_selection_ans {
        Ok(choice) => match choice {
            "Static" => {
                settings.line_num_style = LineNumStyle {
                    num_type: "static".to_owned(),
                }
            }
            "Relative" => {
                settings.line_num_style = LineNumStyle {
                    num_type: "relative".to_owned(),
                }
            }
            _ => panic!("Some error occurred!"),
        },
        Err(_) => panic!("Some error occurred!"),
    }

    println!("\n-----------------------\n");

    let colorschemes_options: Vec<Colorscheme> = vec![
        Colorscheme {
            name: "tokyonight".to_owned(),
            id: "tokyonight-storm".to_owned(),
            install_link: "folke/tokyonight.nvim".to_owned(),
        },
        Colorscheme {
            name: "everforest".to_owned(),
            id: "everforest".to_owned(),
            install_link: "neanias/everforest-nvim".to_owned(),
        },
        Colorscheme {
            name: "gruvbox".to_owned(),
            id: "gruvbox".to_owned(),
            install_link: "ellisonleao/gruvbox.nvim".to_owned(),
        },
    ];
    let colorscheme_ans = Select::new(
        "Select a colorscheme",
        colorschemes_options
            .iter()
            .map(|x| x.name.clone())
            .collect(),
    )
    .prompt();
    match colorscheme_ans {
        Ok(choice) => {
            for color in colorschemes_options {
                if color.name == choice {
                    settings.colorscheme = color.clone();
                }
                // HACK: What if the colorscheme is not found here? should not be possible
            }
        }
        Err(_) => panic!("Some error occurred!"),
    }

    println!("\n-----------------------\n");

    let installation_options = vec!["Default", "Local (detach from git)"];
    let installation_ans = Select::new("Select installation type", installation_options).prompt();

    let is_local: bool;
    match installation_ans {
        Ok(choice) => match choice {
            "Default" => is_local = false,
            "Local (detach from git)" => is_local = true,
            _ => exit(64),
        },
        Err(_) => panic!("Some error occurred!"),
    }

    println!("\n-----------------------\n");

    let clone_options = vec!["SSH (best)", "HTTP"];
    let clone_ans = Select::new("Select cloning type", clone_options).prompt();

    let is_ssh: bool;
    match clone_ans {
        Ok(choice) => match choice {
            "SSH (best)" => is_ssh = true,
            "HTTP" => is_ssh = false,
            _ => exit(64),
        },
        Err(_) => panic!("Some error occurred!"),
    }

    println!("\n-----------------------\n");

    let start_installation_ans = Confirm::new("Procede with cloning and customizing?")
        .with_default(true)
        .prompt();

    match start_installation_ans {
        Ok(true) => {
            clear_screen();
            run_installation(is_local, is_ssh, settings);
        }
        Ok(false) => {
            println!("Exiting...");
            exit(65);
        }
        Err(_) => panic!("Some error occurred!"),
    }
}

/// Starts the installation process
///
/// * `is_local`: Flag true if the installation should be local, false if linked to the remote
/// * `is_ssh`: Flag true if the cloning is done with SSH, false if it uses HTTP
/// * `settings`: Settings object with all the customizations
fn run_installation(is_local: bool, is_ssh: bool, settings: CustomSettings) {
    let mut path_dir_local_config: String;
    let mut path_str = env::var("HOME").expect("Failed retriving HOME path");
    // let mut path_str: String = String::from(p).to_owned();
    path_str.push_str("/.config/nvim");
    clone_repo_to_path(is_ssh, &path_str.clone()[..]);
    println!("{} = repository cloned!", "OK".green());
    path_dir_local_config = path_str.clone();

    if is_local {
        let mut path_git = path_str.clone();
        path_git.push_str("/.git");
        Command::new("rm")
            .args(&["-rf", &path_git[..]])
            .output()
            .expect("Fail removing .git from cloned repo");

        let mut path_gitignore = path_str.clone();
        path_gitignore.push_str("/.gitignore");
        Command::new("rm")
            .args(&["-rf", &path_gitignore[..]])
            .output()
            .expect("Fail removing .git from cloned repo");

        println!("{} = repository completely local!", "OK".green());
    }

    path_dir_local_config.push_str("/lua/marsnvim/localConfig");
    create_directory(&path_dir_local_config.clone()[..]);

    let mut path_file_init = path_dir_local_config.clone();
    path_file_init.push_str("/init.lua");
    create_file(
        &path_file_init.clone()[..],
        "require('marsnvim.localconfig.core')",
    );
    println!("{} = root directory for config created!", "OK".green());

    let mut path_dir_core = path_dir_local_config.clone();
    path_dir_core.push_str("/core");
    create_directory(&path_dir_core.clone()[..]);

    let mut path_file_core = path_dir_core.clone();
    path_file_core.push_str("/init.lua");
    create_file(
        &path_file_core.clone()[..],
        "require('marsnvim.localconfig.core.options')",
    );

    let mut path_file_options = path_dir_core.clone();
    path_file_options.push_str("/options.lua");
    let mut option_content = "local opt = vim.opt\n".to_owned();
    option_content.push_str(settings.line_number().as_str());
    create_file(&path_file_options.clone()[..], option_content.as_str());
    println!("{} = core directory created!", "OK".green());

    let mut path_dir_plugins = path_dir_local_config.clone();
    path_dir_plugins.push_str("/plugins");
    create_directory(&path_dir_plugins.clone()[..]);

    let mut path_file_colorscheme = path_dir_plugins.clone();
    path_file_colorscheme.push_str("/colorscheme.lua");
    let mut colorscheme_content = "".to_owned();
    colorscheme_content.push_str(settings.colorscheme().as_str());
    create_file(
        &path_file_colorscheme.clone()[..],
        colorscheme_content.as_str(),
    );
    println!("{} = plugins directory created!", "OK".green());
}

/// Clones the repository
///
/// * `ssh`: true if the clone should use SSH false if HTTP
/// * `path`: path to clone repository at
fn clone_repo_to_path(ssh: bool, path: &str) {
    let link = if ssh {
        "git@github.com:Mitra98t/marsnvim.git"
    } else {
        "https://github.com/Mitra98t/marsnvim.git"
    };
    Command::new("git")
        .args(&["clone", link, path])
        .output()
        .expect("Some error while cloning repository");
}

/// Create a directory at the specified path
///
/// * `path`: target path of the directory
fn create_directory(path: &str) {
    Command::new("mkdir")
        .args(&[path])
        .output()
        .expect("Some error creating directories");
}

/// Create a file at the specified path and write inside it
///
/// * `path`: target path of the file
/// * `content`: content to put in the file
fn create_file(path: &str, content: &str) {
    let mut file = File::create(path).expect("Some error creating file");
    file.write_all(content.as_bytes())
        .expect("Some error writing in file");
}
