# Introduction
Our Java application is supposed to mimic the Linux Grep command which allows a user to search for a matching string in a file. For the development of this application, we used the IntelliJ IDE, Maven, core java, and docker. Everything was created from a Linux virtual machine using VNC viewer.

# Quick Start
There are two ways of using the app.
no.1

    regex_pattern=".*Romeo.*Juliet.*"
    srccd _dir="./data"
    egrep -r ${regex_pattern} ${src_dir}

no.2

First get the jar file

    wget -O grep-demo.jar htltps://github.com/jarviscanada/jarvis_data_eng_FrancoisLippe/tree/feature/DesignImplementation/core_java/grep/target/grep-1.0-SNAPSHOT.jar


Then run the grep app

    outfile=grep_$(date +%F_%T).txt
    java -jar grep-demo.jar ${regex_pattern} ${src_dir} ./out/${outfile}
#Implemenation
## Pseudocode
###listFiles


    Create an array of files
    for each directory containing files
    if 
        the the file is a file
        add the file to the array
    else
        move to next file


###readLines
    Create a list of strings that reads all lines of a file.

###containsPattern
    if the read lines match the desired patterns
        return true
    else
        return false

###writeToFile
    Create an empty file
    for every string matching
        add to file

###process
    Create an array of string for the matching lines
    for every file
        for every line in the file
            if it contains the desired pattern
                add lines to array
    write to the new file the matched patterns


## Performance Issue
Our grep app laods all the data from the memory to the chosen directory. Then matches the patterr and  outputs the matched lines. This causes outOfMemoryError. What can be done is increase the heap size.

# Test
Using the debugging process of the IntelliJ IDE, I was able to follow every issue I ran into. Such a null error. I was able to find where the app was outputting a null. I was also able to compare my results to those of my teammates. This enabled me to correct any mistakes that I produced.

# Deployment

My application was docerized using my docker hub account. I first logged in locally to my docker account, then created the docker file. Once that was done, I packaged my app using the command `mvn clean package`. Then I created an new docker image locally. Once everything was up and running, I pushed it to docker hub.

# Improvement
1. Time management
2. Problem solving (When stuck on somthing, I need to find a solution faster)
3. Optimise my searched on the net