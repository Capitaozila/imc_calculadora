var doSearch = function (array, targetValue) {
  var min = 0;
  var max = array.length - 1;
  var guess;
  var guesses = 0;

  while (max >= min) {
    guess = floor((max + min) / 2);
    guesses = guesses + 1;

    if (array[guess] === targetValue) {
      println("tentativas: " + guesses);
      return guess;
    } else if (array[guess] < targetValue) {
      min = guess + 1;
    } else {
      max = guess - 1;
    }
    println(array[guess]);
  }

  return -1;
};

var primes = [
  2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71,
  73, 79, 83, 89, 97,
];

var result = doSearch(primes, 73);
println("Primo encontrado no índice " + result);

Program.assertEqual(doSearch(primes, 73), 20);
Program.assertEqual(doSearch(primes, 3), 1);
Program.assertEqual(doSearch(primes, 13), 5);
Program.assertEqual(doSearch(primes, 97), 24);
Program.assertEqual(doSearch(primes, 41), 12);
