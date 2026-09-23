type syntax = Ocaml | Mermaid | Markdown

let generator_name = "CandaceCodegen"

(* This module is the one build-time header configuration. The renderer and
   generated-file checker share these markers; border/wording edits do not
   require a matching list of banner strings elsewhere. Keep the legacy name
   here only for existing Candacegen outputs, without changing their generators. *)
let generated_marker = "generated"
let disclaimer = "DO NOT EDIT"
let ownership_markers =
  List.map (fun name -> generated_marker ^ " by " ^ name)
    [generator_name; "Candacegen"]

let text =
  "Code " ^ generated_marker ^ " by " ^ generator_name ^
  " v0.1.0-dev; the _cgen suffix marks generated files. " ^ disclaimer ^ "."

(* Change this one definition to change the banner on every output owned by
   this compiler. Equals signs also remain valid inside Markdown HTML comments,
   where a dashed separator would contain the forbidden sequence "--". *)
let banner = [
  String.make 60 '/';
  text;
  "===== " ^ disclaimer ^ " =====";
  "Edit the source definition or generator, then regenerate this file.";
  String.make 60 '/';
]

let render syntax =
  let comment line = match syntax with
    | Ocaml -> "(* " ^ line ^ " *)\n"
    | Mermaid -> "%% " ^ line ^ "\n"
    | Markdown -> "<!-- " ^ line ^ " -->\n" in
  String.concat "" (List.map comment banner)
