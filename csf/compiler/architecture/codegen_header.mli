(** One header configuration for the architecture compiler's generated files.
    Edit [banner] in the implementation and rebuild/regenerate to change it; there
    are no environment variables or command-line overrides. *)

type syntax = Ocaml | Mermaid | Markdown

(** Stable generator identity shared with generated-file ownership checks. *)
val generator_name : string

(** The same configured markers drive rendering and generated-file inspection.
    Ownership includes the historical Candacegen name; existing generators and
    protobuf/Liquid Proto naming are unchanged. *)
val generated_marker : string
val disclaimer : string
val ownership_markers : string list

(** The comment body, including the configured development version.
    It is not a release claim or a source revision. Preserve [Code generated],
    [generator_name], the [_cgen] suffix explanation and [DO NOT EDIT.] markers.

    This trusted build-time literal must stay on one line. Wrappers do not
    escape it: avoid double quotes, OCaml comment delimiters and consecutive
    hyphens, which can invalidate OCaml or Hypertext Markup Language (HTML)
    comments. Source-document text
    never enters this value. *)
val text : string

(** The banner body, shared by every output of this compiler. Each list element
    is one comment line; the same comment-safety constraints as [text] apply. *)
val banner : string list

(** Render the configured banner in the selected comment syntax, with one trailing
    newline. Callers put this first and append their own content/blank lines.
    There is deliberately no arbitrary-text argument to this renderer. *)
val render : syntax -> string
