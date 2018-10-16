
conflict("asciidoc")

help(
"Adds asciidoc "..version.." to your PATH environmental variable.\n"
)

local asciidoc_base = pathJoin(apps_dir,"asciidoc")
local asciidoc_dir = pathJoin(asciidoc_base,version)

if isDir(asciidoc_dir) then
else LmodError("module reports "..asciidoc_dir.." is not a directory! Module not loaded." )
end

prepend_path( "PATH", pathJoin(asciidoc_dir, "bin" ) )
prepend_path( "MANPATH", pathJoin(asciidoc_dir, "share/man" ) )

