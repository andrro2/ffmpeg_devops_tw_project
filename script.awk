function array_values(array, before, after) {
    target = ""
    for (key in array) {
        target = target before array[key] after
    } return target
}

function in_array(value, array) {
    is_in_array = 0
    for (i in array) {
        if (array[i] == value) {
            is_in_array = 1
        }
    } return is_in_array
}

function write_shell_script(array) {
    print "CHANGED_DEP=$1\ncase $CHANGED_DEP in" >> output
    
    for (artifact in array)
    {
        tempstring2 = ""
        if(artifact != "artifact"){
            print "\t"artifact")" >> output
            recursive(array, artifact)
            for(stepindex in array["artifact"]["steps"])
            {
                print "\t\t"array["artifact"]["steps"][stepindex] >> output
            }
            print "\t\t;;" >> output
        }
        for (qdep in array[artifact]["deps"])
        {
            
            if(!(array[artifact]["deps"][qdep] in array))
            {
                print "\t"array[artifact]["deps"][qdep]")" >> output
                recursivedep(array, artifact, array[artifact]["deps"][qdep])
                print "\t\t;;" >> output
            }
        }
        
    }
    for(artifact in array){
    if(artifact == "artifact")
        {
            print "\t*)" >> output
            recursive(array, artifact)
            print "\t\t;;" >> output
        }
    }
    

    print "esac\n" >> output
}

function recursive(recarray, recelement)
{
    if(recelement in recarray)
    {
        for(relement in recarray[recelement]["deps"])
        {
            recursive(recarray, recarray[recelement]["deps"][relement])
        }
        for(stepelement in recarray[recelement]["steps"])
        {
            print "\t\t"recarray[recelement]["steps"][stepelement] >> output
        }
    }
}

function recursivedep(recarray2, recelement2, recdep)
{
    isfound=0
    print recdep
    print recelement2
    print (!(recdep in recarray2[recelement2]["deps"]))
    if(!(recdep in recarray2[recelement2]["deps"]))
    {
        print "furok"
        for(recart in recarray2[recelement2]["deps"])
        {
            isfound = recursive(recarray, recarray2[recelement2]["deps"][recart])
        }
        
    }
    else
    {
        print huha
        isfound = 1
    }
    if(isfound){
    for(stepelement2 in recarray2[recelement2]["steps"])
        {
            print "\t\t"recarray2[recelement2]["steps"][stepelement2] >> output
        }
    }
    return isfound
}

BEGIN {
    RS = "\n\n";
    FS = "\t";
    output = "script.sh"
    print "#!/bin/bash\n" > output
    dependencies = 0
}

{
    target = ""
    sub(":", "", $1)
    sub("\n", "", $1)
    target = $1
}

{
    sub("\\ )", "", $3)
    sub("\\( ", "", $3)
    sub("\n", "", $3)
    split($3, dep, ", ")
    for (i in dep) {
        hierarchy[target]["deps"][i] = dep[i]
        dependencies++
    }
    sub("\\ )", "", $5)
    sub("\\( ", "", $5)
    sub("\n", "", $5)
    split($5, step, ", ")
    for (j in step) {
        hierarchy[target]["steps"][j] = step[j]
    }
}

END {
#    for(artifact in hierarchy) {
#        for(dependency in hierarchy[artifact]["steps"]) {
#            print hierarchy[artifact]["steps"][dependency]
#        }
#        for(dependency in hierarchy[artifact]["deps"]) {
#            print hierarchy[artifact]["deps"][dependency]
#        }
#    }

    print "ENNYI VAN: " dependencies

    write_shell_script(hierarchy)

    print "inotifywait sources/ -e close_write | \n" \
    "while read path action file; do \n"\
    "    ARG=$file \n"\
    "done \n" \
    "./script.sh $ARG" >> output
}
