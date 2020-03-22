import React, { useEffect, useState } from "react";

const Data = props => {
  const [questions, setQuestions] = useState([]);

  useEffect(() => {
    const fetchQuestions = async () => {
      const qs = await fetch("/questions.json");
      const parsed = await qs.json();
      setQuestions(parsed);
    };

    fetchQuestions();
  }, []);

  return props.children({ questions });
};

export default Data;
