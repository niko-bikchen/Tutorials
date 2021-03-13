import { useState, useEffect } from 'react';

function useLocalStorageState(key, defaultValue) {
  const [state, setState] = useState(() => {
    let value = null;

    try {
      value = JSON.parse(
        window.localStorage.getItem(key) || String(defaultValue)
      );
    } catch (error) {
      value = defaultValue;
    }

    return value;
  });

  useEffect(() => {
    window.localStorage.setItem(key, JSON.stringify(state));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [state]);

  return [state, setState];
}

export default useLocalStorageState;
