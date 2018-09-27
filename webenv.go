package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {

	log.SetPrefix("INFO: ")
	log.Print("Starting WebApp...")

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Welcome %s ! \n\n", r.URL.Path[1:])

		fmt.Fprintf(w, "I can see Environment Variables: \n\n")

		for _, e := range os.Environ() {
			fmt.Fprintf(w, "  %s\n", e)
		}
	})

	log.SetPrefix("ERROR: ")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
