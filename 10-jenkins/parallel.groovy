node {
  stage ('Parallel') {
    parallel helloBranch: {
      echo 'Hello World'
    },
    loop10Branch: {
      for (int i = 0; i < 10; i++) {
        echo "Hello ${i}"
        sleep(1)
      }
    },
    loop5Branch: {
      for (int i = 0; i < 5; i++) {
        echo "World ${i}"
        sleep(1)
      }
    }
  }
}
