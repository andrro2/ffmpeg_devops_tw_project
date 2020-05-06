
BEGIN {
    RS = "\n\n";
    FS = "\t";
    output = "script.sh"
    print "#!/bin/bash\n" > output
}

{
    target = ""
    sub(":", "", $1)
    target = $1
}

{
    sub("\\ )", "", $3)
    sub("\\( ", "", $3)
    split($3, dep, ", ")
    for (i in dep) {
        hierarchy[target][i] = dep[i]
    }
}
END {
    for(i in hierarchy)
    {
        for(a in hierarchy[i])
        {
            print hierarchy[i][a]
        }
    }
 }