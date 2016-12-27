# Create CSR

    openssl req -subj '/CN=qainstructor.com/C=US/L=Mountain View/ST=CA/O=QA Instructor' -newkey rsa:2048 -nodes -keyout qainstructor.com.pem -out qainstructor.com.csr
