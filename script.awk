BEGIN {
    RS = "\n\n"; ORS = "\n";
    FS = "\t"; OFS = "";
    output = "script.sh"

    print "#!/bin/bash\n" > output
}

{
    gsub(/\n/, "")
    gsub(/ /, "")
    gsub(/:/, "=")
    gsub(/,/, " ")
    print toupper($1) $3 >> output
}

END {
    # final script
 }